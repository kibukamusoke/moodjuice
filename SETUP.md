# MoodJuice App Setup Guide

## Quick Start

For a quick setup and run, use the included script:

```bash
./run.sh
```

## Manual Setup

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Required Code Files

The app uses freezed and riverpod_generator which require code generation:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Setup Supabase

The app uses Supabase for backend functionality:

1. Create a Supabase project at https://supabase.com
2. Use the migrations in the `supabase/migrations` folder to set up tables and functions
3. Apply migrations using the Supabase CLI:
   ```bash
   supabase db push
   ```

### 4. Run The App

```bash
flutter run
```

## App Credentials

The app is already configured with the following Supabase credentials:

- URL: https://glfomdsrcbdjzkfiwhro.supabase.co
- Key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdsZm9tZHNyY2JkanprZml3aHJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3NTM5MTcsImV4cCI6MjA1OTMyOTkxN30.wSdpLUsxKPnGf-OroUYDRWENA1CSPBA-DGNa4WntMsQ

## Key Features

1. **Mood Selection**: Choose from 8 different moods via emoji interface
2. **Juice Generation**: Get a personalized mood juice based on your selection
3. **Activity Suggestions**: Receive a suggested activity to match your mood
4. **User Profiles**: Optional sign-in to save your mood juice history
5. **History View**: View your past mood juices (requires authentication)

## App Structure

See the `STRUCTURE.md` file for a detailed overview of the codebase organization.

## Troubleshooting

- **Flutter Version Issues**: Ensure you have Flutter 3.7.0 or higher
- **Code Generation Errors**: Try running build_runner with the `--delete-conflicting-outputs` flag
- **Supabase Connection Issues**: Verify your internet connection and that the Supabase project is active
- **Build Failures**: Check that all dependencies are properly installed