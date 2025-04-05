import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moodjuice/core/constants.dart';
import 'package:moodjuice/features/models/juice_model.dart';
import 'package:moodjuice/providers/juice_provider.dart';
import 'package:moodjuice/providers/user_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Juice History'),
        centerTitle: true,
      ),
      body: userState.when(
        data: (user) {
          if (user == null) {
            return const _AnonymousHistoryView();
          }
          return _UserHistoryView(userId: user.id);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(
          child: Text('Error loading user profile'),
        ),
      ),
    );
  }
}

class _AnonymousHistoryView extends StatelessWidget {
  const _AnonymousHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Juice History Unavailable',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to save your mood juice history and access it across devices.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/profile'); // Navigate to profile/auth screen
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserHistoryView extends ConsumerWidget {
  final String userId;

  const _UserHistoryView({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juicesAsync = ref.watch(userJuicesProvider(userId));

    return juicesAsync.when(
      data: (juices) {
        if (juices.isEmpty) {
          return const Center(
            child: Text('No juices in your history yet'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: juices.length,
          itemBuilder: (context, index) {
            final juice = juices[index];
            return _JuiceHistoryCard(juice: juice);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
    );
  }
}

class _JuiceHistoryCard extends StatelessWidget {
  final JuiceModel juice;

  const _JuiceHistoryCard({required this.juice});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM dd, yyyy');
    final formattedDate = formatter.format(juice.createdAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  juice.emojiCocktail.split(' ').first, // Just the container emoji
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    juice.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
                Text(
                  juice.mood,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            const Divider(),
            Text(
              juice.description,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.directions_run,
                  size: 16,
                  color: AppConstants.secondaryColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    juice.activity,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
