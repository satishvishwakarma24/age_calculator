import 'package:flutter/material.dart';

import 'routes.dart';
import 'routes_name.dart';

/// Central routing configuration for [MaterialApp].
abstract class AppRouter {
  AppRouter._();

  static const String initialRoute = RoutesName.homeScreen;

  /// All registered named routes (used for validation).
  static const Set<String> registeredRoutes = {
    RoutesName.splashScreen,
    RoutesName.homeScreen,
    RoutesName.calculatorScreen,
    RoutesName.solarSystemScreen,
    RoutesName.compareScreen,
    RoutesName.membersScreen,
    RoutesName.settingsScreen,
  };

  /// Returns true when [name] matches a known route.
  static bool isValidRoute(String? name) {
    if (name == null || name.isEmpty) return false;
    return registeredRoutes.contains(name);
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return Routes.buildRoute(settings);
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const _UnknownRouteScreen(),
    );
  }

  /// Maps deep-link style routes to the home shell tab index.
  static int? homeTabIndexForRoute(String? name) {
    return switch (name) {
      RoutesName.calculatorScreen => 0,
      RoutesName.solarSystemScreen => 2,
      RoutesName.membersScreen => 1,
      RoutesName.settingsScreen => 3,
      RoutesName.compareScreen => 0,
      _ => null,
    };
  }
}

class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white54, size: 48),
            const SizedBox(height: 16),
            Text(
              'Route not found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                RoutesName.homeScreen,
              ),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}
