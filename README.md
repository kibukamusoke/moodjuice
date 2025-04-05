# MoodJuice 🧠🍹

An emotional espresso shot for your soul.

## About MoodJuice

MoodJuice is a Flutter application that generates a daily emotional "juice" based on your mood, providing:

- A drink name (e.g., Spicy Anxiety Latte, Chill Mango Regret Smoothie)
- A vibe breakdown (funny one-liner and emoji cocktail)
- A suggested activity (e.g., "Go touch grass", "Call your mom", "Do 10 squats and scream")
- A custom emoji cocktail for your current mood

## Features

- 😊 Mood selection via emoji interface
- 🍹 Daily juice generation based on mood
- 📱 Beautiful UI with animations
- 📊 History of past mood juices (for logged-in users)
- 👤 User profiles with authentication
- 🔄 Cross-platform support

## Tech Stack

- **Frontend**: Flutter with Riverpod for state management
- **Routing**: GoRouter
- **Backend**: Supabase for authentication, database, and storage
- **UI**: Flutter Animate, Google Fonts, and custom animations

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Supabase CLI (for local development)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/moodjuice.git
   cd moodjuice
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Run the app:
   ```
   flutter run
   ```

### Supabase Setup

The app uses Supabase for backend functionality. The project has been configured with migrations for easy setup:

1. Make sure you have Supabase CLI installed and initialized.

2. Apply the migrations:
   ```
   supabase db push
   ```

3. The migrations will create the necessary tables and seed data.

## App Structure

- **lib/core**: Core functionality (constants, router, Supabase client)
- **lib/features**: Feature-based modules (home, juice, history, profile)
- **lib/providers**: State management with Riverpod
- **lib/models**: Data models
- **supabase/migrations**: Database migrations for Supabase

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- All the emotional people who needed a juice for their feelings
- The designers who made this app look beautiful
- The developers who contributed to the open-source packages used in this project# moodjuice
