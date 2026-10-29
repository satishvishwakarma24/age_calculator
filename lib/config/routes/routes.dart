import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../../core/const.dart';
import '../../age_calc_ui.dart';
import 'app_router.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic>? buildRoute(RouteSettings settings) {
    final name = settings.name;
    if (!AppRouter.isValidRoute(name)) return null;

    final tabIndex = AppRouter.homeTabIndexForRoute(name);
    if (tabIndex != null) {
      return _animatedRoute(
        settings,
        MainShell(initialIndex: tabIndex),
      );
    }

    final Widget page = switch (name) {
      RoutesName.homeScreen => const MainShell(),
      _ => const MainShell(),
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
