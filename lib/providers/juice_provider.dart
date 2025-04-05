import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodjuice/core/supabase_client.dart';
import 'package:moodjuice/features/models/juice_model.dart';

final juiceProvider =
    StateNotifierProvider<JuiceNotifier, AsyncValue<JuiceModel?>>((ref) {
      return JuiceNotifier();
    });

final userJuicesProvider = FutureProvider.family<List<JuiceModel>, String>((
  ref,
  userId,
) async {
  final juices = await SupabaseClientHelper.getUserJuices(userId);
  return juices.map((json) => JuiceModel.fromJson(json)).toList();
});

class JuiceNotifier extends StateNotifier<AsyncValue<JuiceModel?>> {
  JuiceNotifier() : super(const AsyncValue.data(null));

  Future<void> generateJuice(String userId, String mood) async {
    state = const AsyncValue.loading();

    try {
      // Get random activity
      final activity = await SupabaseClientHelper.getRandomActivity();

      // Generate a juice name based on mood
      final juiceName = _generateJuiceName(mood);

      // Generate description
      final description = _generateDescription(mood);

      // Generate emoji cocktail
      final emojiCocktail = _generateEmojiCocktail(mood);

      // Create juice model
      final juice = JuiceModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: juiceName,
        description: description,
        mood: mood,
        activity: activity,
        emojiCocktail: emojiCocktail,
        createdAt: DateTime.now(),
      );

      // Save to Supabase
      await SupabaseClientHelper.saveJuice(userId, juice.toJson());

      state = AsyncValue.data(juice);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void clearJuice() {
    state = const AsyncValue.data(null);
  }

  String _generateJuiceName(String mood) {
    final Map<String, List<String>> prefixes = {
      '😊': ['Happy', 'Joyful', 'Sunshine'],
      '😢': ['Blue', 'Melancholy', 'Tearful'],
      '😡': ['Fiery', 'Spicy', 'Volcanic'],
      '😴': ['Dreamy', 'Sleepy', 'Calm'],
      '🤔': ['Curious', 'Thoughtful', 'Pondering'],
      '😬': ['Anxious', 'Jittery', 'Nervous'],
      '🥰': ['Loving', 'Affectionate', 'Sweet'],
      '🥱': ['Tired', 'Worn-out', 'Sluggish'],
    };

    final Map<String, List<String>> drinks = {
      '😊': ['Smoothie', 'Lemonade', 'Fizz'],
      '😢': ['Tea', 'Chardonnay', 'Cocoa'],
      '😡': ['Espresso', 'Hot Sauce', 'Chili'],
      '😴': ['Chamomile', 'Lullaby', 'Nightcap'],
      '🤔': ['Elixir', 'Potion', 'Brain Juice'],
      '😬': ['Jitter Juice', 'Cold Brew', 'Tonic'],
      '🥰': ['Nectar', 'Honey', 'Crush'],
      '🥱': ['Herbal Tea', 'Warm Milk', 'Zzzz Juice'],
    };

    // Fallback if the mood is not in the map
    final prefix =
        prefixes[mood]?[DateTime.now().millisecond % 3] ?? 'Mysterious';
    final drink = drinks[mood]?[DateTime.now().second % 3] ?? 'Concoction';

    final flavors = [
      'Mango',
      'Blueberry',
      'Strawberry',
      'Vanilla',
      'Mint',
      'Cinnamon',
      'Lemon',
      'Coconut',
    ];
    final flavor = flavors[DateTime.now().minute % flavors.length];

    return '$prefix $flavor $drink';
  }

  String _generateDescription(String mood) {
    final Map<String, List<String>> descriptions = {
      '😊': [
        'A splash of sunshine in a glass!',
        'Tastes like the perfect summer day.',
        'Guaranteed to keep that smile going!',
      ],
      '😢': [
        'A soothing blend for when the world feels heavy.',
        'Let those tears fuel your emotional glow-up.',
        "Sometimes it's okay to feel blue, like this delicious potion.",
      ],
      '😡': [
        'Channel that anger into something productive... like drinking this!',
        'Spicy and intense, just like your current mood.',
        'This fiery concoction understands your rage.',
      ],
      '😴': [
        'The perfect companion for your lazy day.',
        'Sip slowly and embrace the dreamy vibes.',
        'Even your juice wants to take a nap with you.',
      ],
      '🤔': [
        'A thoughtful blend to accompany your deep ponderings.',
        'Might not have all the answers, but tastes great anyway!',
        "For when you're stuck in a philosophical loop.",
      ],
      '😬': [
        'Take a deep breath and sip this anxious elixir.',
        'Jittery outside, calm inside.',
        'Even your juice is slightly nervous, but in a cute way.',
      ],
      '🥰': [
        'Love in liquid form, basically.',
        'Heart eyes for this sweet concoction!',
        "Share with someone special... or don't. It's YOUR juice.",
      ],
      '🥱': [
        'Even this juice is tired of today.',
        'Pairs well with a nap.',
        'For when you simply cannot anymore.',
      ],
    };

    // Return a random description based on mood
    return descriptions[mood]?[DateTime.now().second % 3] ??
        'A mysterious blend with unexpected qualities...';
  }

  String _generateEmojiCocktail(String mood) {
    // Base ingredients by mood
    final Map<String, List<String>> baseEmojis = {
      '😊': ['🌞', '✨', '🌈'],
      '😢': ['🌧️', '💧', '🫧'],
      '😡': ['🔥', '💥', '🌶️'],
      '😴': ['💤', '🌙', '🌑'],
      '🤔': ['💭', '🧠', '❓'],
      '😬': ['⚡', '💫', '😰'],
      '🥰': ['❤️', '💝', '💕'],
      '🥱': ['🥱', '☕', '🛌'],
    };

    // Additional ingredients
    final garnishes = [
      '🍋',
      '🍊',
      '🍒',
      '🥝',
      '🍇',
      '🥥',
      '🍍',
      '🍌',
      '🌿',
      '🧊',
      '🍯',
    ];
    final containers = ['🥤', '🧉', '🍹', '🍸', '☕', '🫖', '🍶', '🥛'];

    // Get base ingredients for the mood
    final baseList = baseEmojis[mood] ?? ['✨', '🌟', '⭐'];
    final base = baseList[DateTime.now().millisecond % baseList.length];

    // Get random additions
    final garnish1 = garnishes[DateTime.now().second % garnishes.length];
    final garnish2 = garnishes[(DateTime.now().second + 3) % garnishes.length];
    final container = containers[DateTime.now().minute % containers.length];

    // Assemble the cocktail
    return '$container $base $garnish1 $garnish2 $mood';
  }
}
