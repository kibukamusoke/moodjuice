import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodjuice/core/constants.dart';
import 'package:moodjuice/core/router.dart';
import 'package:moodjuice/core/supabase_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseClientHelper.initialize();

  // Run the app
  runApp(const ProviderScope(child: MoodJuiceApp()));
}

class MoodJuiceApp extends ConsumerWidget {
  const MoodJuiceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'MoodJuice',
      theme: _buildTheme(AppTheme.lightTheme),
      darkTheme: _buildTheme(AppTheme.darkTheme),
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}
