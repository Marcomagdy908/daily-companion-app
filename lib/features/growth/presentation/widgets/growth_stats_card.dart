// ─── features/growth/presentation/widgets/growth_stats_card.dart ───────
// Daily Companion (رفيق يومي) — Growth stats display card
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/growth_state.dart';

class GrowthStatsCard extends StatelessWidget {
  final GrowthState growth;

  const GrowthStatsCard({super.key, required this.growth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: '🔥',
            value: '${growth.currentStreak}',
            label: 'اليوم الحالي',
            color: growth.currentStreak > 0 ? Colors.orange : Colors.grey,
          ),
          _Divider(),
          _StatItem(
            icon: '🏆',
            value: '${growth.longestStreak}',
            label: 'أطول مدة',
            color: AppTheme.accentColor,
          ),
          _Divider(),
          _StatItem(
            icon: '🍃',
            value: '${growth.leavesEarned}',
            label: 'ورقة نمت',
            color: AppTheme.growthGreen,
          ),
          _Divider(),
          _StatItem(
            icon: '✅',
            value: '${growth.totalCommitmentsCompleted}',
            label: 'التزام مكتمل',
            color: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}
