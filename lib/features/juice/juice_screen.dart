import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodjuice/core/constants.dart';
import 'package:moodjuice/providers/juice_provider.dart';

class JuiceScreen extends ConsumerWidget {
  const JuiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juiceState = ref.watch(juiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go(AppConstants.routeHome);
          },
        ),
      ),
      body: juiceState.when(
        data: (juice) {
          if (juice == null) {
            // No juice generated yet, show fallback
            return const Center(
              child: Text('No juice found, go back and create one!'),
            );
          }

          // Juice is available, show the juice details
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Juice title with animation
                  Center(
                    child: Text(
                      juice.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
                  ),
                  const SizedBox(height: 40),

                  // Emoji cocktail with animation
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          juice.emojiCocktail,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ).animate().scale(begin: Offset(0.8, 0.8), end: Offset(1, 1), duration: 800.ms).shimmer(
                          duration: 1200.ms,
                          color: AppConstants.secondaryColor.withOpacity(0.3),
                        ),
                  ),
                  const SizedBox(height: 40),

                  // Description card
                  _buildInfoCard(
                    context,
                    title: 'Today\'s Vibe',
                    content: juice.description,
                    icon: Icons.bubble_chart,
                    delay: 200,
                  ),
                  const SizedBox(height: 16),

                  // Activity suggestion card
                  _buildInfoCard(
                    context,
                    title: 'Suggested Activity',
                    content: juice.activity,
                    icon: Icons.directions_run,
                    delay: 400,
                  ),
                  const SizedBox(height: 40),

                  // Share button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Implement share functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sharing your juice with the world! 🌎'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share My Juice'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required String title,
      required String content,
      required IconData icon,
      required int delay}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppConstants.primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideX();
  }
}
