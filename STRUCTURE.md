# MoodJuice App Structure

## Directory Structure

```
├── assets/                    # App assets
│   ├── animations/           # Lottie and Rive animations
│   └── images/               # Images and icons
├── lib/                      # Source code
│   ├── core/                 # Core functionalities
│   │   ├── constants.dart    # App-wide constants
│   │   ├── router.dart       # GoRouter configuration
│   │   └── supabase_client.dart # Supabase initialization and helpers
│   ├── features/             # Feature modules
│   │   ├── history/          # History screen
│   │   │   └── history_screen.dart
│   │   ├── home/             # Home screen
│   │   │   └── home_screen.dart
│   │   ├── juice/            # Juice generation screen
│   │   │   └── juice_screen.dart
│   │   ├── models/           # Data models
│   │   │   ├── juice_model.dart
│   │   │   └── user_model.dart
│   │   └── profile/          # User profile and auth
│   │       └── profile_screen.dart
│   ├── providers/            # State management
│   │   ├── juice_provider.dart # Juice state provider
│   │   └── user_provider.dart  # User state provider
│   └── main.dart             # App entry point
├── supabase/                 # Supabase configuration
│   └── migrations/           # Database migrations
│       ├── 20250404000000_initial_schema.sql
│       └── 20250404000001_functions.sql
├── pubspec.yaml              # Flutter dependencies
└── README.md                 # Project documentation
```

## Key Components

### State Management

The app uses Riverpod for state management. Key providers include:

- `userProvider`: Manages user authentication state
- `juiceProvider`: Handles juice generation and retrieval

### Routing

GoRouter is used for navigation:

- `/`: Home screen with mood selection
- `/juice`: Generated juice display
- `/history`: Juice history for logged-in users
- `/profile`: User profile and authentication

### Supabase Tables

- `users`: Extended user profiles
- `moods`: Records of user mood selections
- `juice`: Stored generated juices
- `activities`: Suggested activities pool