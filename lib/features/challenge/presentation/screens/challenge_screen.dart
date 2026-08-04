// ─── features/challenge/presentation/screens/challenge_screen.dart ─────
// Daily Companion (رفيق يومي) — 30-Day Spiritual Challenge Module
//
// Each day unlocks a new topic. Day 2 only unlocks after Day 1 is done.
// Sequential unlocking logic is enforced server-side and client-side.
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/challenge_day.dart';
import '../../../../providers/challenge_provider.dart';
import '../widgets/challenge_day_card.dart';
import '../widgets/challenge_progress_bar.dart';
import 'challenge_day_detail_screen.dart';

class ChallengeScreen extends ConsumerWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daysAsync = ref.watch(challengeDaysProvider);
    final progress = ref.watch(challengeProgressProvider);
    final completedCount = ref.watch(challengeCompletedCountProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F4F0), Color(0xFFEFEBE5), Color(0xFFF8F4F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, progress, completedCount),
              Expanded(
                child: daysAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text('خطأ: $err')),
                  data: (days) => _buildDaysGrid(context, ref, days, progress),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, double progress, int completedCount) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'تحدي الـ ٣٠ يوم',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
          )
              .animate()
              .fadeIn(duration: 500.ms),

          const SizedBox(height: 4),

          Text(
            'رحلة روحية يومية لتقوية علاقتك بالله',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),

          const SizedBox(height: 20),

          ChallengeProgressBar(
            progress: progress,
            completedCount: completedCount,
            totalDays: 30,
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 300.ms)
              .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),

          const SizedBox(height: 8),

          // ── Legend ──────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color: AppTheme.growthGreen, label: 'مكتمل'),
              const SizedBox(width: 16),
              _LegendDot(color: AppTheme.accentColor, label: 'متاح'),
              const SizedBox(width: 16),
              _LegendDot(color: Colors.grey.shade300, label: 'مقفل'),
            ],
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildDaysGrid(
    BuildContext context,
    WidgetRef ref,
    List<ChallengeDay> days,
    double progress,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final delay = (200 + index * 50).ms;

        return ChallengeDayCard(
          day: day,
          onTap: () {
            if (day.isUnlocked || day.isCompleted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChallengeDayDetailScreen(
                    day: day,
                    onComplete: (journalEntry) {
                      ref.read(challengeDaysProvider.notifier).completeDay(
                            dayNumber: day.dayNumber,
                            journalEntry: journalEntry,
                          );
                    },
                  ),
                ),
              );
            }
          },
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: delay)
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 400.ms,
              delay: delay,
            );
      },
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11)),
      ],
    );
  }
}
