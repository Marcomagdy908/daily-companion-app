// ─── features/challenge/presentation/widgets/challenge_day_card.dart ───
// Daily Companion (رفيق يومي) — Day card for the 30-day challenge grid
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/challenge_day.dart';

class ChallengeDayCard extends StatelessWidget {
  final ChallengeDay day;
  final VoidCallback onTap;

  const ChallengeDayCard({
    super.key,
    required this.day,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = !day.isUnlocked && !day.isCompleted && day.dayNumber > 1;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: day.isCompleted
              ? AppTheme.growthGreen.withOpacity(0.1)
              : isLocked
                  ? Colors.grey.withOpacity(0.05)
                  : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: day.isCompleted
                ? AppTheme.growthGreen.withOpacity(0.4)
                : isLocked
                    ? Colors.grey.withOpacity(0.2)
                    : AppTheme.accentColor.withOpacity(0.3),
            width: day.isCompleted ? 2 : 1,
          ),
          boxShadow: isLocked
              ? null
              : [
                  BoxShadow(
                    color: (day.isCompleted
                            ? AppTheme.growthGreen
                            : AppTheme.accentColor)
                        .withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Icon ──────────────────────────────────────────────────
            if (day.isCompleted)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.growthGreen.withOpacity(0.15),
                ),
                child: const Icon(Icons.check, color: AppTheme.growthGreen, size: 20),
              )
            else if (isLocked)
              const Icon(Icons.lock_outline, color: Colors.grey, size: 22)
            else
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentColor.withOpacity(0.1),
                ),
                child: Text(
                  '${day.dayNumber}',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),

            const SizedBox(height: 8),

            // ── Label ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                day.topic,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: day.isCompleted
                      ? AppTheme.growthGreen
                      : isLocked
                          ? Colors.grey
                          : AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
