// ─── features/challenge/presentation/widgets/challenge_progress_bar.dart
// Daily Companion (رفيق يومي) — Challenge progress visualization
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ChallengeProgressBar extends StatelessWidget {
  final double progress; // 0.0 – 1.0
  final int completedCount;
  final int totalDays;

  const ChallengeProgressBar({
    super.key,
    required this.progress,
    required this.completedCount,
    required this.totalDays,
  });

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تقدم التحدي',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '$completedCount / $totalDays يوم',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.growthGreen,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: AppTheme.growthGreen.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(
                AppTheme.growthGreen,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${(progress * 100).toInt()}% مكتمل',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
