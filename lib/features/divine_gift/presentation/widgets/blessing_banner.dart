// ─── features/divine_gift/presentation/widgets/blessing_banner.dart ────
// Daily Companion (رفيق يومي) — Blessing reminder banner
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class BlessingBanner extends StatelessWidget {
  final String blessing;

  const BlessingBanner({super.key, required this.blessing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accentColor.withOpacity(0.15),
            AppTheme.accentColor.withOpacity(0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentColor.withOpacity(0.15),
            ),
            child: const Text('🌟', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تذكير البركة',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.accentColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  blessing,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                      ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
