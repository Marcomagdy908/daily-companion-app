// ─── features/divine_gift/presentation/screens/gift_screen.dart ────────
// Daily Companion (رفيق يومي) — Divine Gift of the Day screen
//
// This is the first screen the user sees each morning. It displays:
//   - The verse of the day
//   - A short spiritual reflection
//   - A blessing reminder
//
// CORE LOGIC: Reading this screen triggers the "Altar of the Heart"
// commitment requirement. The user must commit before the day is complete.
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/daily_lock_provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/navigation_provider.dart';
import '../../../../models/daily_status.dart';
import '../../../../services/gift_service.dart';
import '../../../../services/notification_service.dart';
import '../widgets/gift_card.dart';
import '../widgets/blessing_banner.dart';

class GiftScreen extends ConsumerStatefulWidget {
  const GiftScreen({super.key});

  @override
  ConsumerState<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends ConsumerState<GiftScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _hasMarkedRead = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGiftRead() {
    if (_hasMarkedRead) return;
    _hasMarkedRead = true;
    ref.read(dailyStatusProvider.notifier).markGiftRead();
  }

  void _navigateToCommitment() {
    // Switch to Altar of the Heart tab (index 1)
    ref.read(navigationIndexProvider.notifier).state = 1;
  }

  @override
  Widget build(BuildContext context) {
    final giftAsync = ref.watch(todayGiftProvider);
    final statusAsync = ref.watch(dailyStatusProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.divineGradient),
        child: SafeArea(
          child: statusAsync.when(
            loading: () => const _LoadingView(),
            error: (err, _) => _ErrorView(message: err.toString()),
            data: (status) {
              return giftAsync.when(
                loading: () => const _LoadingView(),
                error: (err, _) => _ErrorView(message: err.toString()),
                data: (gift) {
                  // Trigger read tracking
                  if (!_hasMarkedRead && gift != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _onGiftRead();
                    });
                  }

                  return _buildContent(context, gift, status);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, gift, DailyStatus status) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Morning Greeting ────────────────────────────────────
            _MorningGreeting(
              onTestNotification: gift != null
                  ? () async {
                      await NotificationService().showInstantGiftNotification(gift);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🔔 تم إرسال إشعار العطية الفوري!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  : null,
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0, duration: 600.ms),

            const SizedBox(height: 32),

            // ── Gift Card (Verse + Reflection) ──────────────────────
            if (gift != null)
              GiftCard(gift: gift)
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 300.ms)
                  .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1))
              else
              _NoGiftCard()
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 300.ms),

            const SizedBox(height: 24),

            // ── Blessing Banner ─────────────────────────────────────
            if (gift != null)
              BlessingBanner(blessing: gift.blessingReminder)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideX(begin: 0.3, end: 0),

            const SizedBox(height: 40),

            // ── CTA: Go to Altar of the Heart ───────────────────────
            if (!status.commitmentMade)
              _CommitmentButton(onPressed: _navigateToCommitment)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 900.ms)
                  .slideY(begin: 0.3, end: 0),

            if (status.commitmentMade)
              _DayCompleteBanner()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 900.ms),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ─── Morning Greeting Widget ────────────────────────────────────────────
class _MorningGreeting extends StatelessWidget {
  final VoidCallback? onTestNotification;

  const _MorningGreeting({this.onTestNotification});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'صباح الخير ☀️'
        : hour < 17
            ? 'نهار مبارك 🌤️'
            : 'مساء الخير 🌙';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 40),
            Expanded(
              child: Text(
                greeting,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            if (onTestNotification != null)
              IconButton(
                onPressed: onTestNotification,
                tooltip: 'تجربة إشعار العطية',
                icon: const Icon(
                  Icons.notifications_active_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              )
            else
              const SizedBox(width: 40),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'ما يمنحه الله لك اليوم',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ─── Commitment CTA Button ──────────────────────────────────────────────
class _CommitmentButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CommitmentButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Text('🔥', style: TextStyle(fontSize: 20)),
        label: const Text('ماذا ستعطي اليوم؟'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

// ─── Day Complete Banner ────────────────────────────────────────────────
class _DayCompleteBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.growthGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.growthGreen.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Text('✅', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أحسنت! تم تسجيل التزامك اليوم.',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.growthGreen,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'شجرة علاقتك بالله تنمو 🌱',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Loading View ──────────────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppTheme.accentColor),
          SizedBox(height: 16),
          Text('جاري تحميل عطية اليوم...'),
        ],
      ),
    );
  }
}

// ─── Error View ────────────────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
            const SizedBox(height: 24),
            Text(
              'حدث خطأ في تحميل عطية اليوم',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── No Gift Card (fallback with Seed button for debug) ──────────────
class _NoGiftCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('🌅', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            'لم يتم إعداد عطية اليوم بعد.\nتفضل بالعودة لاحقًا.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          TextButton.icon(

              onPressed: () async {
                final today = DateTime.now();
                final dateStr = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
                
                await GiftService().createGift(
                  date: dateStr,
                  verseReference: 'أمثال 23: 26',
                  verseText: 'يَا ابْنِي أَعْطِنِي قَلْبَكَ، وَلْتُلاَحِظْ عَيْنَاكَ طُرُقِي.',
                  reflection: 'الله لا يطلب منا سوى قلبنا المخلص ليملأه بمحبته وسلامه، وحين تلاحظ عيناك طرقه تجد النور والأمان.',
                  blessingReminder: 'أعظم حاجة نقدمها لربنا هي قلبنا.. حاول دائماً تخلي قلبك ذبيحة حية مرضية لربنا 🤍🕊️',
                );
                
                ref.invalidate(todayGiftProvider);
                ref.invalidate(dailyStatusProvider);
              },
              icon: const Icon(Icons.auto_fix_high, size: 16),
              label: const Text('توليد عطية تجريبية (Debug)'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryColor.withOpacity(0.6),
              ),
            ),
        ],
      ),
    );
  }
}
