// ─── features/home/presentation/screens/home_screen.dart ──────────────
// Daily Companion (رفيق يومي) — Main home shell with bottom nav
//
// Navigation structure:
//   1. Divine Gift (الهدية)     — Home tab
//   2. Altar of Heart (المذبح)  — Commitment tab
//   3. Growth Tree (النمو)      — Growth indicator tab
//   4. Challenge (التحدي)        — 30-day challenge tab
//   5. Curriculum (المنهج)       — Full curriculum flashcards tab
//   6. Settings (الإعدادات)      — Profile & settings
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../divine_gift/presentation/screens/gift_screen.dart';
import '../../../altar/presentation/screens/altar_screen.dart';
import '../../../growth/presentation/screens/growth_screen.dart';
import '../../../challenge/presentation/screens/challenge_screen.dart';
import '../../../curriculum/presentation/screens/curriculum_screen.dart';

import '../../../../providers/navigation_provider.dart';

import '../widgets/welcome_tutorial_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> _screens = const [
    GiftScreen(),
    AltarScreen(),
    GrowthScreen(),
    ChallengeScreen(),
    CurriculumScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WelcomeTutorialDialog.showIfFirstTime(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: _screens,
          ),
          // Floating Info / Tutorial Button
          Positioned(
            left: 16,
            top: MediaQuery.of(context).padding.top + 8,
            child: Material(
              color: Colors.white.withOpacity(0.85),
              shape: const CircleBorder(),
              elevation: 2,
              child: IconButton(
                icon: const Icon(Icons.info_outline_rounded, color: AppTheme.primaryColor, size: 20),
                tooltip: 'شرح التطبيق',
                onPressed: () => WelcomeTutorialDialog.showAlways(context),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: '🌅',
                  label: 'الهدية',
                  isActive: currentIndex == 0,
                  onTap: () => ref.read(navigationIndexProvider.notifier).state = 0,
                ),
                _NavItem(
                  icon: '🔥',
                  label: 'المذبح',
                  isActive: currentIndex == 1,
                  onTap: () => ref.read(navigationIndexProvider.notifier).state = 1,
                ),
                _NavItem(
                  icon: '🌱',
                  label: 'النمو',
                  isActive: currentIndex == 2,
                  onTap: () => ref.read(navigationIndexProvider.notifier).state = 2,
                ),
                _NavItem(
                  icon: '📅',
                  label: 'التحدي',
                  isActive: currentIndex == 3,
                  onTap: () => ref.read(navigationIndexProvider.notifier).state = 3,
                ),
                _NavItem(
                  icon: '📖',
                  label: 'المنهج',
                  isActive: currentIndex == 4,
                  onTap: () => ref.read(navigationIndexProvider.notifier).state = 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: TextStyle(fontSize: isActive ? 26 : 22)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
