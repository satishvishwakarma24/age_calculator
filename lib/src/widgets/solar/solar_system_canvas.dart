import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────
//  SolarSystemCanvas
//  Custom-painted solar system with:
//    • Glowing sun at centre
//    • Orbit rings
//    • Animated orbiting planet dots
//  Height is fixed at 200px; the canvas is
//  square internally and clips to the box.
// ─────────────────────────────────────────────

class SolarSystemCanvas extends StatefulWidget {
  /// Which planets to show (by index, 0 = Mercury … 7 = Neptune)
  final List<int> visiblePlanets;

  const SolarSystemCanvas({
    super.key,
    this.visiblePlanets = const [0, 1, 2, 3, 4, 5, 6, 7],
  });

  @override
  State<SolarSystemCanvas> createState() => _SolarSystemCanvasState();
}

class _SolarSystemCanvasState extends State<SolarSystemCanvas>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  static const _planets = [
    _PlanetDef('Mercury', Color(0xFFBDBDBD), 36, 2.6),
    _PlanetDef('Venus',   Color(0xFFFFCC02), 52, 1.2),
    _PlanetDef('Earth',   Color(0xFF4FC3F7), 68, 1.0),
    _PlanetDef('Mars',    Color(0xFFFF7043), 82, 0.6),
    _PlanetDef('Jupiter', Color(0xFFFFAB40), 98, 0.25),
    _PlanetDef('Saturn',  Color(0xFFF3E5AB), 114, 0.18),
    _PlanetDef('Uranus',  Color(0xFF80DEEA), 128, 0.12),
    _PlanetDef('Neptune', Color(0xFF5C6BC0), 140, 0.08),
  ];

  static const _startAngles = [0.0, 1.2, 2.5, 4.0, 0.8, 2.0, 3.5, 5.0];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return CustomPaint(
            painter: _SolarPainter(
              t: _ctrl.value * 2 * math.pi,
              visibleIndices: widget.visiblePlanets,
              planets: _planets,
              startAngles: _startAngles,
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _SolarPainter — CustomPainter
// ─────────────────────────────────────────────

class _SolarPainter extends CustomPainter {
  final double t;
  final List<int> visibleIndices;
  final List<_PlanetDef> planets;
  final List<double> startAngles;

  const _SolarPainter({
    required this.t,
    required this.visibleIndices,
    required this.planets,
    required this.startAngles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // ── Orbit rings ────────────────────────────────
    final orbitPaint = Paint()
      ..color = AppColors.starBlue.withOpacity(0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (int i = 0; i < planets.length; i++) {
      if (visibleIndices.contains(i)) {
        canvas.drawCircle(
          Offset(cx, cy),
          planets[i].orbitRadius.toDouble(),
          orbitPaint,
        );
      }
    }

    // ── Sun ────────────────────────────────────────
    final sunGlow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..color = AppColors.sun.withOpacity(0.5);
    canvas.drawCircle(Offset(cx, cy), 16, sunGlow);

    final sunPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFFACC), Color(0xFFFFD700), Color(0xFFFF8C00)],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 14));
    canvas.drawCircle(Offset(cx, cy), 14, sunPaint);

    // ── Planets ───────────────────────────────────
    for (int i in visibleIndices) {
      if (i >= planets.length) continue;
      final p = planets[i];
      final angle = t * p.speed + startAngles[i];
      final px = cx + p.orbitRadius * math.cos(angle);
      final py = cy + p.orbitRadius * math.sin(angle);

      // glow
      final glowPaint = Paint()
        ..color = p.color.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(Offset(px, py), 6, glowPaint);

      // planet body
      final pPaint = Paint()..color = p.color;
      canvas.drawCircle(Offset(px, py), 4.5, pPaint);
    }
  }

  @override
  bool shouldRepaint(_SolarPainter old) => old.t != t;
}

class _PlanetDef {
  final String name;
  final Color color;
  final int orbitRadius;   // logical pixels from centre
  final double speed;      // angular speed multiplier

  const _PlanetDef(this.name, this.color, this.orbitRadius, this.speed);
}