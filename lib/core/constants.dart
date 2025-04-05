import 'package:flutter/material.dart';

class AppConstants {
  // Supabase
  static const String supabaseUrl = 'https://glfomdsrcbdjzkfiwhro.supabase.co';
  static const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdsZm9tZHNyY2JkanprZml3aHJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3NTM5MTcsImV4cCI6MjA1OTMyOTkxN30.wSdpLUsxKPnGf-OroUYDRWENA1CSPBA-DGNa4WntMsQ';

  // Routes
  static const String routeHome = '/';
  static const String routeJuice = '/juice';
  static const String routeProfile = '/profile';
  static const String routeHistory = '/history';

  // Collections
  static const String collectionMoods = 'moods';
  static const String collectionJuice = 'juice';
  static const String collectionActivities = 'activities';
  static const String collectionUsers = 'users';

  // Colors - Clean White Theme
  static const Color primaryColor = Color(0xFF2C7DFA);    // Clean blue
  static const Color secondaryColor = Color(0xFF34BE82);  // Fresh teal/green
  static const Color accentColor = Color(0xFFFFA726);     // Soft orange accent
  static const Color backgroundColor = Color(0xFFFFFFFF); // Pure white
  static const Color darkBackgroundColor = Color(0xFF303030);
  static const Color textColor = Color(0xFF303030);       // Dark gray (not black)
  static const Color errorColor = Color(0xFFE53935);      // Clean red
}

class AppTheme {
  static const double borderRadius = 16.0;
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.secondaryColor,
      background: AppConstants.backgroundColor,
      surface: Colors.white,
      error: AppConstants.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppConstants.textColor,
      onSurface: AppConstants.textColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey[50], // Very light gray background for contrast
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 1.0,
      shadowColor: Colors.black.withOpacity(0.05),
      iconTheme: const IconThemeData(color: AppConstants.primaryColor),
      titleTextStyle: const TextStyle(
        color: AppConstants.textColor, 
        fontSize: 20, 
        fontWeight: FontWeight.w600
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppConstants.primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppConstants.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppConstants.errorColor),
      ),
      contentPadding: const EdgeInsets.all(mediumPadding),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 1,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.secondaryColor,
      background: const Color(0xFF1A1A1A),
      surface: const Color(0xFF242424),
      error: AppConstants.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF242424),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppConstants.primaryColor),
      titleTextStyle: TextStyle(
        color: Colors.white, 
        fontSize: 20, 
        fontWeight: FontWeight.w600
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppConstants.primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Color(0xFF444444), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Color(0xFF444444), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppConstants.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppConstants.errorColor),
      ),
      contentPadding: const EdgeInsets.all(mediumPadding),
      hintStyle: TextStyle(color: Colors.grey[600]),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF242424),
      elevation: 1,
      surfaceTintColor: const Color(0xFF242424),
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
