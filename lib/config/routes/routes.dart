import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:age_calculator/core/const.dart';
import 'package:age_calculator/config/routes/app_router.dart';
import 'package:age_calculator/config/routes/routes_name.dart';
import 'package:age_calculator/src/views/home_view.dart';
import 'package:age_calculator/src/views/splash_view.dart';

class Routes {
  static Route<dynamic>? buildRoute(RouteSettings settings) {
    final name = settings.name;
    if (!AppRouter.isValidRoute(name)) return null;

    final tabIndex = AppRouter.homeTabIndexForRoute(name);
    if (tabIndex != null) {
      return _animatedRoute(
        settings,
        HomeView(initialIndex: tabIndex),
      );
    }

    final Widget page = switch (name) {
      RoutesName.splashScreen => const SplashView(),
      RoutesName.homeScreen => const HomeView(),
      _ => const HomeView(),
    };

    return _animatedRoute(settings, page);
  }

  static PageRouteBuilder<void> _animatedRoute(
    RouteSettings settings,
    Widget page,
  ) {
    return PageRouteBuilder<void>(
      settings: settings,
      transitionDuration: AppAnimations.normal,
      reverseTransitionDuration: AppAnimations.fast,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
    );
  }
}
