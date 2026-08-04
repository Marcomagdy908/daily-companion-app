// ─── features/growth/presentation/screens/growth_screen.dart ───────────
// Daily Companion (رفيق يومي) — مؤشر نمو العلاقة: Growth Indicator
//
// This is the gamification core. A visual tree (or light) that grows
// when the user completes their daily commitment.
//
// Animation states:
//   - GROWING:  New leaves appear, trunk thickens, gold particles
//   - STAGNANT: Tree sways gently, waiting for commitment
//   - WITHERING: Leaves fall (missed days), branch colors fade
// ────────────────────────────────────────────────────────────────────────

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/growth_state.dart';
import '../../../../providers/daily_lock_provider.dart';
import '../widgets/growth_tree_painter.dart';
import '../widgets/growth_stats_card.dart';
import '../widgets/growth_light_painter.dart';

class GrowthScreen extends ConsumerStatefulWidget {
  const GrowthScreen({super.key});

  @override
  ConsumerState<GrowthScreen> createState() => _GrowthScreenState();
}

class _GrowthScreenState extends ConsumerState<GrowthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _swayController;
  bool _showGrowthAnimation = false;

  @override
  void initState() {
    super.initState();
    _swayController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _swayController.dispose();
    super.dispose();
  }

  /// Trigger a growth animation when commitment is made
  void _triggerGrowthAnimation() {
    setState(() => _showGrowthAnimation = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showGrowthAnimation = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final growthAsync = ref.watch(growthStateProvider);
    final statusAsync = ref.watch(dailyStatusProvider);

    // Trigger growth anim when day completes
    ref.listen<AsyncValue<DailyStatus>>(dailyStatusProvider, (prev, next) {
      final wasComplete = prev?.valueOrNull?.dayComplete ?? false;
      final isComplete = next.valueOrNull?.dayComplete ?? false;
      if (!wasComplete && isComplete) {
        _triggerGrowthAnimation();
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F7F0), Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: growthAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('خطأ: $err')),
            data: (growth) => _buildGrowthView(context, growth),
          ),
        ),
      ),
    );
  }

  Widget _buildGrowthView(BuildContext context, GrowthState growth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),

          // ── Title ───────────────────────────────────────────────────
          Text(
            'نمو علاقتك بالله',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 500.ms),

          const SizedBox(height: 4),

          Text(
            _getGrowthMessage(growth),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),

          const SizedBox(height: 24),

          // ── The Tree / Light Visualization ──────────────────────────
          _buildVisual(context, growth),

          const SizedBox(height: 24),

          // ── Growth Stats ────────────────────────────────────────────
          GrowthStatsCard(growth: growth)
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 24),

          // ── Growth Level Progress Bar ───────────────────────────────
          _buildProgressBar(context, growth)
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms),

          const SizedBox(height: 32),

          // ── Milestone Section ────────────────────────────────────────
          _buildMilestones(context, growth)
              .animate()
              .fadeIn(duration: 600.ms, delay: 800.ms),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildVisual(BuildContext context, GrowthState growth) {
    final size = MediaQuery.of(context).size.width - 48;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Tree Canvas ──────────────────────────────────────────────
          Container(
            key: ValueKey('tree_${growth.growthLevel}'),
            width: size,
            height: size * 1.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.growthGreen.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AnimatedBuilder(
                animation: _swayController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: GrowthTreePainter(
                      growthLevel: growth.growthLevel / 100.0,
                      leavesCount: growth.leavesEarned,
                      swayValue: _swayController.value,
                      isGrowing: _showGrowthAnimation,
                      streakActive: growth.currentStreak > 0,
                    ),
                    size: Size(size, size * 1.1),
                  );
                },
              ),
            ),
          ),

          // ── Growth + Particles Overlay ──────────────────────────────
          if (_showGrowthAnimation)
            ...List.generate(15, (i) {
              final rng = Random(i);
              return Positioned(
                left: size * (0.3 + rng.nextDouble() * 0.4),
                top: size * (0.2 + rng.nextDouble() * 0.5),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: [
                      Colors.amber,
                      AppTheme.growthGreen,
                      AppTheme.accentColor,
                    ][rng.nextInt(3)],
                  ),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .fadeOut(duration: 500.ms)
                    .moveY(
                      begin: 0,
                      end: -40,
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    )
                    .scale(
                      begin: const Offset(1.5, 1.5),
                      end: const Offset(0, 0),
                      duration: 800.ms,
                    ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, GrowthState growth) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مستوى النمو',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '${growth.growthLevel} / 100',
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
              value: growth.growthLevel / 100.0,
              minHeight: 12,
              backgroundColor: AppTheme.growthGreen.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(AppTheme.growthGreen),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _getNextMilestone(growth),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestones(BuildContext context, GrowthState growth) {
    final milestones = [
      {'level': 10, 'icon': '🌱', 'label': 'بداية النمو', 'reached': growth.growthLevel >= 10},
      {'level': 25, 'icon': '🌿', 'label': 'النمو المستمر', 'reached': growth.growthLevel >= 25},
      {'level': 50, 'icon': '🌳', 'label': 'شجرة ثابتة', 'reached': growth.growthLevel >= 50},
      {'level': 75, 'icon': '🌺', 'label': 'إزهار', 'reached': growth.growthLevel >= 75},
      {'level': 100, 'icon': '🌟', 'label': 'نور كامل', 'reached': growth.growthLevel >= 100},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مراحل النمو',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          ...milestones.map((m) {
            final reached = m['reached'] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: reached
                          ? AppTheme.growthGreen.withOpacity(0.15)
                          : Colors.grey.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Opacity(
                        opacity: reached ? 1.0 : 0.3,
                        child: Text(
                          m['icon'] as String,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      m['label'] as String,
                      style: TextStyle(
                        color: reached ? AppTheme.textPrimary : Colors.grey,
                        fontWeight: reached ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (reached) const Icon(Icons.check_circle, color: AppTheme.growthGreen, size: 20),
                  if (!reached) Text(
                    'المستوى ${m['level']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────

  String _getGrowthMessage(GrowthState growth) {
    if (growth.currentStreak == 0) return 'ابدأ بالتزامك اليوم لينمو المؤشر';
    if (growth.currentStreak < 3) return 'بداية رائعة! استمر في الالتزام اليومي 🌱';
    if (growth.currentStreak < 7) return 'علاقتك بالله تنمو بقوة 🌿';
    if (growth.currentStreak < 14) return 'أنت في طريقك لشجرة إيمان ثابتة 🌳';
    if (growth.currentStreak < 30) return 'إيمانك يزهر ويثمر 🌺';
    return 'نور علاقتك بالله يشع من حولك 🌟';
  }

  String _getNextMilestone(GrowthState growth) {
    if (growth.growthLevel < 10) return 'الهدف التالي: 🌱 بداية النمو (المستوى 10)';
    if (growth.growthLevel < 25) return 'الهدف التالي: 🌿 النمو المستمر (المستوى 25)';
    if (growth.growthLevel < 50) return 'الهدف التالي: 🌳 شجرة ثابتة (المستوى 50)';
    if (growth.growthLevel < 75) return 'الهدف التالي: 🌺 إزهار (المستوى 75)';
    if (growth.growthLevel < 100) return 'الهدف التالي: 🌟 نور كامل (المستوى 100)';
    return '🎉 لقد وصلت لأعلى مستوى!';
  }
}
