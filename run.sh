#!/bin/bash

# MoodJuice App Setup and Run Script

echo "🧠🍹 MoodJuice App Setup"
echo "======================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "   Visit https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check flutter version
FLUTTER_VERSION=$(flutter --version | head -1 | awk '{print $2}')
echo "✅ Flutter version: $FLUTTER_VERSION"

# Fetch dependencies
echo "📦 Fetching dependencies..."
flutter pub get

# Run freezed and riverpod generators
echo "🔄 Running code generators..."
flutter pub run build_runner build --delete-conflicting-outputs

# Check if Supabase CLI is installed
if command -v supabase &> /dev/null; then
    echo "✅ Supabase CLI is installed."
    
    # Ask if the user wants to push migrations
    read -p "Do you want to push Supabase migrations? (y/n): " PUSH_MIGRATIONS
    if [[ $PUSH_MIGRATIONS == "y" || $PUSH_MIGRATIONS == "Y" ]]; then
        echo "🔄 Pushing Supabase migrations..."
        supabase db push
    fi
else
    echo "ℹ️ Supabase CLI is not installed."
    echo "   If you want to push migrations, install Supabase CLI:"
    echo "   https://supabase.com/docs/guides/cli"
fi

# Run the app
echo "🚀 Starting MoodJuice app..."
flutter run

echo "✨ Done!"