// ─── features/growth/presentation/widgets/growth_tree_painter.dart ─────
// Daily Companion (رفيق يومي) — Custom painter for the growth tree
//
// Draws a stylized tree that grows leaves progressively based on the
// user's spiritual growth level and streak.
// ────────────────────────────────────────────────────────────────────────

import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class GrowthTreePainter extends CustomPainter {
  final double growthLevel; // 0.0 – 1.0
  final int leavesCount;
  final double swayValue; // -1.0 to 1.0 for gentle sway
  final bool isGrowing;
  final bool streakActive;

  GrowthTreePainter({
    required this.growthLevel,
    required this.leavesCount,
    required this.swayValue,
    required this.isGrowing,
    required this.streakActive,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final baseY = size.height * 0.85;
    final trunkHeight = size.height * 0.4;
    final canopyCenterY = baseY - trunkHeight - size.height * 0.05;
    final canopyRadius = size.width * 0.32;

    // ── Ground ────────────────────────────────────────────────────────
    _drawGround(canvas, size, centerX, baseY);

    // ── Trunk ─────────────────────────────────────────────────────────
    _drawTrunk(canvas, centerX, baseY, trunkHeight);

    // ── Soil / Base Circle ────────────────────────────────────────────
    _drawSoil(canvas, centerX, baseY);

    // ── Branches ──────────────────────────────────────────────────────
    _drawBranches(canvas, centerX, baseY, trunkHeight, canopyCenterY, canopyRadius);

    // ── Canopy (leaf clusters) ────────────────────────────────────────
    _drawCanopy(canvas, canopyCenterY, canopyRadius, size);

    // ── Individual Leaves ─────────────────────────────────────────────
    _drawLeaves(canvas, canopyCenterY, canopyRadius, size);

    // ── Growth Particles (when actively growing) ──────────────────────
    if (isGrowing) {
      _drawGrowthParticles(canvas, canopyCenterY, canopyRadius);
    }

    // ── Sun / Light source at top ─────────────────────────────────────
    _drawSun(canvas, size);

    // ── Water drops for active streak ─────────────────────────────────
    if (streakActive) {
      _drawWaterDrop(canvas, centerX, baseY, size);
    }
  }

  void _drawGround(Canvas canvas, Size size, double centerX, double baseY) {
    final groundPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF8BC34A).withOpacity(0.3),
          const Color(0xFF4CAF50).withOpacity(0.1),
        ],
      ).createShader(Rect.fromLTWH(0, baseY, size.width, size.height - baseY));

    final groundPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, baseY + 5)
      ..quadraticBezierTo(centerX * 0.5, baseY - 10, centerX, baseY)
      ..quadraticBezierTo(centerX * 1.5, baseY - 10, size.width, baseY + 5)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(groundPath, groundPaint);

    // Small grass blades
    final grassPaint = Paint()
      ..color = const Color(0xFF66BB6A).withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rng = Random(42);
    for (int i = 0; i < 20; i++) {
      final gx = rng.nextDouble() * size.width;
      final gh = 8.0 + rng.nextDouble() * 15;
      canvas.drawLine(
        Offset(gx, baseY),
        Offset(gx + swayValue * 3, baseY - gh),
        grassPaint,
      );
    }
  }

  void _drawTrunk(Canvas canvas, double centerX, double baseY, double trunkHeight) {
    final trunkWidth = 12.0 + growthLevel * 16.0; // Grows thicker with level

    final trunkPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFF5D4037),
          const Color(0xFF795548),
          const Color(0xFF5D4037),
        ],
      ).createShader(Rect.fromLTWH(
        centerX - trunkWidth,
        baseY - trunkHeight,
        trunkWidth * 2,
        trunkHeight,
      ));

    final trunkPath = Path()
      ..moveTo(centerX - trunkWidth * 0.4, baseY)
      ..quadraticBezierTo(
        centerX - trunkWidth * 0.6,
        baseY - trunkHeight * 0.5,
        centerX - trunkWidth * 0.3,
        baseY - trunkHeight,
      )
      ..lineTo(centerX + trunkWidth * 0.3, baseY - trunkHeight)
      ..quadraticBezierTo(
        centerX + trunkWidth * 0.6,
        baseY - trunkHeight * 0.5,
        centerX + trunkWidth * 0.4,
        baseY,
      )
      ..close();

    canvas.drawPath(trunkPath, trunkPaint);

    // Trunk texture lines
    final texturePaint = Paint()
      ..color = const Color(0xFF4E342E).withOpacity(0.3)
      ..strokeWidth = 1;

    for (int i = 1; i <= 4; i++) {
      final ty = baseY - trunkHeight * (i / 5);
      canvas.drawLine(
        Offset(centerX - trunkWidth * 0.25, ty),
        Offset(centerX + trunkWidth * 0.25, ty),
        texturePaint,
      );
    }
  }

  void _drawSoil(Canvas canvas, double centerX, double baseY) {
    final soilPaint = Paint()
      ..color = const Color(0xFF6D4C41).withOpacity(0.3);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX, baseY),
        width: 36,
        height: 14,
      ),
      soilPaint,
    );
  }

  void _drawBranches(Canvas canvas, double centerX, double baseY,
      double trunkHeight, double canopyCenterY, double canopyRadius) {
    final branchPaint = Paint()
      ..color = const Color(0xFF6D4C41)
      ..strokeWidth = 4.0 + growthLevel * 3.0
      ..strokeCap = StrokeCap.round;

    final numBranches = (3 + growthLevel * 5).round();
    final rng = Random(123);

    for (int i = 0; i < numBranches; i++) {
      final angle = -pi / 2 + (rng.nextDouble() - 0.5) * pi * 0.9;
      final branchLength = canopyRadius * (0.4 + rng.nextDouble() * 0.6);
      final sway = swayValue * 0.05 * rng.nextDouble();

      final startX = centerX;
      final startY = baseY - trunkHeight;
      final endX = startX + cos(angle + sway) * branchLength;
      final endY = startY + sin(angle + sway) * branchLength;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        branchPaint,
      );
    }
  }

  void _drawCanopy(Canvas canvas, double canopyCenterY, double canopyRadius, Size size) {
    final centerX = size.width / 2;

    // Multiple overlapping circles for a fluffy canopy effect
    final numClusters = (3 + growthLevel * 5).round();
    final rng = Random(456);

    for (int i = 0; i < numClusters; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final distance = canopyRadius * (0.2 + rng.nextDouble() * 0.5);
      final cx = centerX + cos(angle) * distance;
      final cy = canopyCenterY + sin(angle) * distance * 0.7;
      final cr = canopyRadius * (0.25 + rng.nextDouble() * 0.35);

      final opacity = 0.5 + growthLevel * 0.5;
      final clusterPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppTheme.growthGreen.withOpacity(opacity),
            AppTheme.growthGreen.withOpacity(opacity * 0.6),
            const Color(0xFF2E7D32).withOpacity(opacity * 0.3),
          ],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: cr));

      canvas.drawCircle(Offset(cx, cy), cr, clusterPaint);
    }
  }

  void _drawLeaves(Canvas canvas, double canopyCenterY, double canopyRadius, Size size) {
    final centerX = size.width / 2;
    final leavesToDraw = min(leavesCount, 100);
    if (leavesToDraw == 0 && !streakActive) return;

    final leafPaint = Paint()
      ..style = PaintingStyle.fill;

    final rng = Random(789);

    for (int i = 0; i < leavesToDraw; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final distance = canopyRadius * (0.15 + rng.nextDouble() * 0.75);
      final lx = centerX + cos(angle) * distance;
      final ly = canopyCenterY + sin(angle) * distance * 0.7;

      // Vary leaf colors
      final leafColors = [
        const Color(0xFF66BB6A),
        const Color(0xFF4CAF50),
        const Color(0xFF43A047),
        const Color(0xFF81C784),
        const Color(0xFFA5D6A7),
      ];

      leafPaint.color = leafColors[rng.nextInt(leafColors.length)];

      // Draw tiny leaf shape
      final leafAngle = rng.nextDouble() * 2 * pi;
      final leafSize = 4.0 + rng.nextDouble() * 6.0;

      canvas.save();
      canvas.translate(lx, ly);
      canvas.rotate(leafAngle);

      final leafPath = Path()
        ..moveTo(0, -leafSize)
        ..quadraticBezierTo(leafSize * 0.4, -leafSize * 0.3, 0, leafSize * 0.5)
        ..quadraticBezierTo(-leafSize * 0.4, -leafSize * 0.3, 0, -leafSize);

      canvas.drawPath(leafPath, leafPaint);
      canvas.restore();
    }

    // Extra "new growth" tiny leaves during active streak
    if (streakActive && leavesToDraw < 100) {
      final newLeafPaint = Paint()..color = const Color(0xFF8BC34A);
      for (int i = 0; i < 3; i++) {
        final angle = rng.nextDouble() * 2 * pi;
        final distance = canopyRadius * (0.7 + rng.nextDouble() * 0.2);
        final lx = centerX + cos(angle) * distance;
        final ly = canopyCenterY + sin(angle) * distance * 0.7;

        canvas.save();
        canvas.translate(lx, ly);
        canvas.rotate(rng.nextDouble() * 2 * pi);

        final leafPath = Path()
          ..moveTo(0, -3)
          ..quadraticBezierTo(2, -1, 0, 2)
          ..quadraticBezierTo(-2, -1, 0, -3);
        canvas.drawPath(leafPath, newLeafPaint);
        canvas.restore();
      }
    }
  }

  void _drawGrowthParticles(Canvas canvas, double canopyCenterY, double canopyRadius) {
    final particlePaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;

    final rng = Random(DateTime.now().millisecond);
    for (int i = 0; i < 8; i++) {
      final offset = rng.nextDouble() * canopyRadius * 0.8;
      final angle = rng.nextDouble() * 2 * pi;
      final px = (size.width / 2) + cos(angle) * offset;
      final py = canopyCenterY + sin(angle) * offset;

      canvas.drawCircle(Offset(px, py), 2.0, particlePaint);
    }
  }

  void _drawSun(Canvas canvas, Size size) {
    final sunX = size.width * 0.8;
    final sunY = size.height * 0.1;

    // Sun glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFF176).withOpacity(0.4),
          const Color(0xFFFFF176).withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(sunX, sunY), radius: 50));

    canvas.drawCircle(Offset(sunX, sunY), 50, glowPaint);

    // Sun core
    final sunPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFF9C4),
          const Color(0xFFFFF176),
        ],
      ).createShader(Rect.fromCircle(center: Offset(sunX, sunY), radius: 22));

    canvas.drawCircle(Offset(sunX, sunY), 22, sunPaint);
  }

  void _drawWaterDrop(Canvas canvas, double centerX, double baseY, Size size) {
    // Small watering can or drop indicating active care
    final dropPaint = Paint()
      ..color = const Color(0xFF42A5F5).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final dropPath = Path()
      ..moveTo(centerX + 40, baseY - 30)
      ..cubicTo(
        centerX + 42,
        baseY - 20,
        centerX + 45,
        baseY - 15,
        centerX + 42,
        baseY - 10,
      )
      ..cubicTo(
        centerX + 39,
        baseY - 5,
        centerX + 35,
        baseY - 5,
        centerX + 33,
        baseY - 10,
      )
      ..cubicTo(
        centerX + 31,
        baseY - 15,
        centerX + 34,
        baseY - 20,
        centerX + 36,
        baseY - 30,
      )
      ..close();

    canvas.drawPath(dropPath, dropPaint);
  }

  @override
  bool shouldRepaint(covariant GrowthTreePainter oldDelegate) {
    return oldDelegate.growthLevel != growthLevel ||
        oldDelegate.leavesCount != leavesCount ||
        oldDelegate.swayValue != swayValue ||
        oldDelegate.isGrowing != isGrowing ||
        oldDelegate.streakActive != streakActive;
  }
}
