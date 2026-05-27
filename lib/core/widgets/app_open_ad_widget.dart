import 'package:flutter/material.dart';

/// App open ads are shown once on cold start from [SplashView] only.
/// This wrapper exists so [MaterialApp] can stay wrapped without resume ads.
class AppOpenAdWidget extends StatelessWidget {
  final Widget child;

  const AppOpenAdWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}
