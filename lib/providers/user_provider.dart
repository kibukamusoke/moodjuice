import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodjuice/features/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<UserModel?>>((ref) {
      return UserNotifier();
    });

class UserNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  UserNotifier() : super(const AsyncValue.data(null)) {
    // Check for existing session on initialization
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      await getUserProfile();
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        // Create a new user model
        final newUser = UserModel(id: response.user!.id, email: email);
        
        print('Creating user record in database with ID: ${newUser.id}');
        
        // IMPORTANT: Create the user record in the database
        await Supabase.instance.client.from('users').insert(newUser.toJson());
        
        state = AsyncValue.data(newUser);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e) {
      print('Error during signup: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await getUserProfile();
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getUserProfile() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      print('Current user ID from auth: $userId');
      
      if (userId == null) {
        print('No authenticated user found');
        state = const AsyncValue.data(null);
        return;
      }

      try {
        final response = await Supabase.instance.client
            .from('users')
            .select()
            .eq('id', userId)
            .single();
        
        print('User profile response: $response');

        if (response != null) {
          final user = UserModel.fromJson(response as Map<String, dynamic>);
          print('Successfully loaded user: ${user.id}, email: ${user.email}');
          state = AsyncValue.data(user);
        } else {
          print('User exists in auth but not in database, creating profile');
          // User exists in auth but not in users table
          final newUser = UserModel(
            id: userId,
            email: Supabase.instance.client.auth.currentUser!.email!,
          );

          // Create user profile
          await Supabase.instance.client.from('users').insert(newUser.toJson());
          print('Created new user profile: ${newUser.id}');

          state = AsyncValue.data(newUser);
        }
      } catch (e) {
        print('Error fetching user profile: $e');
        
        // Create user profile if it doesn't exist
        print('Attempting to create missing user profile');
        final newUser = UserModel(
          id: userId,
          email: Supabase.instance.client.auth.currentUser!.email!,
        );

        await Supabase.instance.client.from('users').insert(newUser.toJson());
        print('Created new user profile after error: ${newUser.id}');
        
        state = AsyncValue.data(newUser);
      }
    } catch (e) {
      print('Fatal error in getUserProfile: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateProfile({String? name, String? avatarUrl}) async {
    final currentUser = state.value;
    if (currentUser == null) return;

    try {
      final updatedUser = currentUser.copyWith(
        name: name ?? currentUser.name,
        avatarUrl: avatarUrl ?? currentUser.avatarUrl,
      );

      await Supabase.instance.client
          .from('users')
          .update(updatedUser.toJson())
          .eq('id', updatedUser.id);

      state = AsyncValue.data(updatedUser);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> completeOnboarding() async {
    final currentUser = state.value;
    if (currentUser == null) return;

    try {
      final updatedUser = currentUser.copyWith(hasCompletedOnboarding: true);

      await Supabase.instance.client
          .from('users')
          .update(updatedUser.toJson())
          .eq('id', updatedUser.id);

      state = AsyncValue.data(updatedUser);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
