// ─── features/divine_gift/presentation/widgets/gift_card.dart ──────────
// Daily Companion (رفيق يومي) — Elegant verse card widget
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/daily_gift.dart';

class GiftCard extends StatelessWidget {
  final DailyGift gift;

  const GiftCard({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentColor.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 12),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Icon Banner ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.divineLight,
              border: Border.all(
                color: AppTheme.accentColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Text('📜', style: TextStyle(fontSize: 36)),
          ),
          const SizedBox(height: 24),

          // ── Verse Reference ──────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              gift.verseReference,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Verse Text ───────────────────────────────────────────
          Text(
            gift.verseText,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Amiri',
                  height: 1.8,
                  color: AppTheme.textPrimary,
                ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),

          // ── Divider ──────────────────────────────────────────────
          Container(
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: AppTheme.accentColor.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 20),

          // ── Reflection ───────────────────────────────────────────
          Text(
            gift.reflection,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
