import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodjuice/core/constants.dart';
import 'package:moodjuice/providers/juice_provider.dart';
import 'package:moodjuice/providers/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String? _selectedMood;

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '😴', 'label': 'Sleepy'},
    {'emoji': '🤔', 'label': 'Thoughtful'},
    {'emoji': '😬', 'label': 'Anxious'},
    {'emoji': '🥰', 'label': 'Loving'},
    {'emoji': '🥱', 'label': 'Tired'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onMoodSelected(String mood) {
    setState(() {
      _selectedMood = mood;
    });
  }

  void _generateJuice() {
    if (_selectedMood == null) return;
    
    final userState = ref.read(userProvider);
    // Get the current authenticated user ID from Supabase
    final authUserId = Supabase.instance.client.auth.currentUser?.id;
    
    print('Auth user ID: $authUserId');
    print('Provider user state: ${userState.value?.id}');
    
    if (authUserId == null) {
      // No authenticated user, handle anon juice generation
      final anonUserId = 'anon-${DateTime.now().millisecondsSinceEpoch}';
      print('Using anonymous ID: $anonUserId');
      ref.read(juiceProvider.notifier).generateJuice(anonUserId, _selectedMood!);
    } else if (userState.value == null) {
      // Auth user exists but not in our provider, try to refresh
      print('Auth user exists but not in provider, refreshing profile');
      ref.read(userProvider.notifier).getUserProfile().then((_) {
        // Use the auth ID directly since profile might not be loaded yet
        print('Using auth ID after refresh: $authUserId');
        ref.read(juiceProvider.notifier).generateJuice(authUserId, _selectedMood!);
      });
    } else {
      // User is logged in and in provider
      print('User logged in, using ID: ${userState.value!.id}');
      ref.read(juiceProvider.notifier).generateJuice(userState.value!.id, _selectedMood!);
    }
    
    context.push(AppConstants.routeJuice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mood',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor,
                  ),
            ),
            Text(
              'Juice',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.secondaryColor,
                  ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'How are you feeling today?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppConstants.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select a mood to get your personalized juice',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _moods.length,
                itemBuilder: (context, index) {
                  final mood = _moods[index];
                  final isSelected = _selectedMood == mood['emoji'];
                  return GestureDetector(
                    onTap: () => _onMoodSelected(mood['emoji']),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppConstants.primaryColor.withOpacity(0.05)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppConstants.primaryColor
                              : Colors.grey.shade200,
                          width: isSelected ? 1.5 : 1,
                        ),
                        boxShadow: isSelected 
                            ? [
                                BoxShadow(
                                  color: AppConstants.primaryColor.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mood['emoji'],
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mood['label'],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? AppConstants.primaryColor
                                  : Colors.grey.shade700,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _selectedMood != null 
                        ? [
                            BoxShadow(
                              color: AppConstants.primaryColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ]
                        : [],
                  ),
                  child: ElevatedButton(
                    onPressed: _selectedMood != null ? _generateJuice : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: Colors.grey.shade200,
                      disabledForegroundColor: Colors.grey.shade500,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Brew My Mood Juice',
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _animationController.value * 0.2,
                              child: const Text(
                                '🍹',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
