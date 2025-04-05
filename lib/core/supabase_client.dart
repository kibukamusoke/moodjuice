import 'package:moodjuice/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientHelper {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseKey,
    );
  }

  static SupabaseClient get instance => Supabase.instance.client;

  // Mood methods
  static Future<void> saveMood(String userId, String mood) async {
    await Supabase.instance.client.from(AppConstants.collectionMoods).insert({
      'user_id': userId,
      'mood': mood,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Juice methods
  static Future<void> saveJuice(
    String userId,
    Map<String, dynamic> juice,
  ) async {
    try {
      print('Saving juice with data: $juice');
      
      final dataToInsert = {
        'user_id': userId,
        'name': juice['name'],
        'description': juice['description'],
        'mood': juice['mood'],
        'activity': juice['activity'],
        'emoji_cocktail': juice['emoji_cocktail'] ?? juice['emojiCocktail'], // Try both formats
        'created_at': DateTime.now().toIso8601String(),
      };
      
      print('Inserting data: $dataToInsert');
      await Supabase.instance.client.from(AppConstants.collectionJuice).insert(dataToInsert);
      print('Juice saved successfully');
    } catch (e) {
      print('Error saving juice: $e');
      rethrow;
    }
  }

  // Get user juices history
  static Future<List<Map<String, dynamic>>> getUserJuices(String userId) async {
    final response = await Supabase.instance.client
        .from(AppConstants.collectionJuice)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // Activities methods
  static Future<String> getRandomActivity() async {
    try {
      // Get all activities (assuming this is a small table)
      final response = await Supabase.instance.client
          .from(AppConstants.collectionActivities)
          .select('activity');

      if (response.isNotEmpty) {
        // Generate a random index
        final random = DateTime.now().millisecondsSinceEpoch % response.length;
        return response[random]['activity'] as String;
      }
    } catch (e) {
      print('Error getting random activity: $e');
    }

    return "Go touch grass.";
  }
}
