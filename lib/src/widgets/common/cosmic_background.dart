import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────
//  CosmicBackground
//  Renders a radial deep-space gradient with
//  randomly placed twinkling star particles.
//  Wrap any screen's body with this widget.
// ─────────────────────────────────────────────

class CosmicBackground extends StatefulWidget {
  final Widget child;
  final int starCount;

  const CosmicBackground({
    super.key,
    required this.child,
    this.starCount = 80,
  });

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with TickerProviderStateMixin {
  late final List<_Star> _stars;
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    final rand = math.Random();
    _stars = List.generate(widget.starCount, (i) {
      return _Star(
        x: rand.nextDouble(),
        y: rand.nextDouble(),
        size: rand.nextDouble() * 2 + 0.5,
        opacity: rand.nextDouble() * 0.5 + 0.1,
        phaseOffset: rand.nextDouble() * 2 * math.pi,
      );
    });

    _controllers = List.generate(widget.starCount, (i) {
      final ctrl = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + math.Random().nextInt(2000)),
      )..repeat(reverse: true);
      return ctrl;
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cosmic = CosmicTheme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Radial deep-space gradient ──────────────────
        DecoratedBox(
          decoration: BoxDecoration(gradient: cosmic.backgroundGradient),
        ),
        // ── Star field ──────────────────────────────────
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: List.generate(_stars.length, (i) {
                final star = _stars[i];
                return AnimatedBuilder(
                  animation: _controllers[i],
                  builder: (_, __) {
                    final t = _controllers[i].value;
                    final opacity = star.opacity * 0.3 +
                        star.opacity * 0.7 * ((math.sin(t * math.pi) + 1) / 2);
                    return Positioned(
                      left: star.x * constraints.maxWidth,
                      top: star.y * constraints.maxHeight,
                      child: Container(
                        width: star.size,
                        height: star.size,
                        decoration: BoxDecoration(
                          color: cosmic.starParticle.withValues(alpha: opacity),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          },
        ),
        // ── Content ─────────────────────────────────────
        widget.child,
      ],
    );
  }
}

class _Star {
  final double x, y, size, opacity, phaseOffset;
  const _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.phaseOffset,
  });
}