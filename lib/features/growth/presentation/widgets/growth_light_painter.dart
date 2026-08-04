// ─── features/growth/presentation/widgets/growth_light_painter.dart ────
// Daily Companion (رفيق يومي) — Alternative "light" visualization
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class GrowthLightPainter extends CustomPainter {
  final double brightness; // 0.0 – 1.0

  GrowthLightPainter({required this.brightness});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 0.4;

    // Outer glow
    final outerGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD54F).withOpacity(0.6 * brightness),
          const Color(0xFFFFD54F).withOpacity(0.2 * brightness),
          const Color(0xFFFFD54F).withOpacity(0.0),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));

    canvas.drawCircle(center, maxRadius, outerGlowPaint);

    // Medium glow
    final mediumGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFECB3).withOpacity(0.9 * brightness),
          const Color(0xFFFFD54F).withOpacity(0.4 * brightness),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius * 0.6));

    canvas.drawCircle(center, maxRadius * 0.6, mediumGlowPaint);

    // Core light
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(brightness),
          const Color(0xFFFFF9C4).withOpacity(0.8 * brightness),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius * 0.25));

    canvas.drawCircle(center, maxRadius * 0.25, corePaint);

    // Light rays
    final rayPaint = Paint()
      ..color = const Color(0xFFFFD54F).withOpacity(0.3 * brightness)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final angle = (i / 12) * 2 * 3.14159;
      final innerRadius = maxRadius * 0.3;
      final outerRadius = maxRadius * (0.5 + brightness * 0.5);

      canvas.drawLine(
        Offset(
          center.dx + cos(angle) * innerRadius,
          center.dy + sin(angle) * innerRadius,
        ),
        Offset(
          center.dx + cos(angle) * outerRadius,
          center.dy + sin(angle) * outerRadius,
        ),
        rayPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GrowthLightPainter oldDelegate) {
    return oldDelegate.brightness != brightness;
  }
}
