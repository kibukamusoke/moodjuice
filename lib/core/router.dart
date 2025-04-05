import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodjuice/core/constants.dart';
import 'package:moodjuice/features/history/history_screen.dart';
import 'package:moodjuice/features/home/home_screen.dart';
import 'package:moodjuice/features/juice/juice_screen.dart';
import 'package:moodjuice/features/profile/profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppConstants.routeHome,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: AppConstants.routeHome,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppConstants.routeJuice,
          builder: (context, state) => const JuiceScreen(),
        ),
        GoRoute(
          path: AppConstants.routeHistory,
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: AppConstants.routeProfile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _calculateSelectedIndex(context),
          onTap: (index) => _onItemTapped(index, context),
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          backgroundColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.local_drink_outlined), activeIcon: Icon(Icons.local_drink), label: 'Juice'),
            BottomNavigationBarItem(icon: Icon(Icons.history_outlined), activeIcon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == AppConstants.routeHome) {
      return 0;
    }
    if (location == AppConstants.routeJuice) {
      return 1;
    }
    if (location == AppConstants.routeHistory) {
      return 2;
    }
    if (location == AppConstants.routeProfile) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppConstants.routeHome);
      case 1:
        GoRouter.of(context).go(AppConstants.routeJuice);
      case 2:
        GoRouter.of(context).go(AppConstants.routeHistory);
      case 3:
        GoRouter.of(context).go(AppConstants.routeProfile);
      default:
        GoRouter.of(context).go(AppConstants.routeHome);
    }
  }
}
