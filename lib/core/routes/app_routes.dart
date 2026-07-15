import 'package:flutter/material.dart';
import 'package:kids_learning/features/home/presentation/pages/splash_screen.dart';
import 'package:kids_learning/features/home/presentation/pages/home_screen.dart';
import 'package:kids_learning/features/game/presentation/pages/category_selection_screen.dart';
import 'package:kids_learning/features/parent/presentation/pages/parent_mode_screen.dart';
import 'package:kids_learning/features/settings/presentation/pages/settings_screen.dart';
import 'package:kids_learning/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:kids_learning/features/achievements/presentation/pages/achievements_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String categorySelection = '/categories';
  static const String parentDashboard = '/parents';
  static const String settings = '/settings';
  static const String achievements = '/achievements';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return _buildAnimatedRoute(const OnboardingScreen());
      case home:
        return _buildAnimatedRoute(const HomeScreen());
      case categorySelection:
        return _buildAnimatedRoute(const CategorySelectionScreen());
      case parentDashboard:
        return _buildAnimatedRoute(const ParentModeScreen());
      case settings:
        return _buildAnimatedRoute(const SettingsScreen());
      case achievements:
        return _buildAnimatedRoute(const AchievementsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${routeSettings.name}')),
          ),
        );
    }
  }

  static Route<dynamic> _buildAnimatedRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOutBack),
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
