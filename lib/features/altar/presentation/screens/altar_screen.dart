// ─── features/altar/presentation/screens/altar_screen.dart ─────────────
// Daily Companion (رفيق يومي) — مذبح القلب: Altar of the Heart
//
// CORE LOGIC: The user MUST submit their daily commitment here.
// Without it, the day is NOT complete and growth pauses.
// This is the "Give" half of "Mutual Giving" (Give and Take).
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../models/altar_commitment.dart';
import '../../../../providers/daily_lock_provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/navigation_provider.dart';
import '../widgets/commitment_type_selector.dart';
import '../widgets/commitment_preset_chips.dart';

class AltarScreen extends ConsumerStatefulWidget {
  const AltarScreen({super.key});

  @override
  ConsumerState<AltarScreen> createState() => _AltarScreenState();
}

class _AltarScreenState extends ConsumerState<AltarScreen> {
  CommitmentType? _selectedType;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSubmitting = false;
  late ConfettiController _confettiController;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _safeNavigateBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(true);
    } else {
      ref.read(navigationIndexProvider.notifier).state = 0;
    }
  }

  Future<void> _submitCommitment() async {
    if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك اختر نوع الالتزام أولاً')),
      );
      return;
    }

    final description = _descriptionController.text.trim();
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك اكتب التزامك')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;

      await ref.read(dailyStatusProvider.notifier).submitCommitment(
            userId: user.uid,
            type: _selectedType!,
            description: description,
          );

      // Trigger confetti celebration
      setState(() => _showConfetti = true);
      _confettiController.play();

      // Navigate back after a brief celebration
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        _safeNavigateBack();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(dailyStatusProvider);

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C3E50), Color(0xFF1A252F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: statusAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (err, _) => Center(
                  child: Text('خطأ: $err', style: const TextStyle(color: Colors.white)),
                ),
                data: (status) {
                  if (status.commitmentMade) {
                    return const _AlreadyCommittedView();
                  }
                  return _buildCommitmentForm(context);
                },
              ),
            ),
          ),
        ),
        // ── Confetti overlay ──────────────────────────────────────────
        if (_showConfetti)
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                AppTheme.accentColor,
                AppTheme.growthGreen,
                AppTheme.altarRose,
                Colors.white,
                Colors.amber,
              ],
              numberOfParticles: 30,
              maxBlastForce: 15,
              minBlastForce: 5,
            ),
          ),
      ],
    );
  }

  Widget _buildCommitmentForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header Bar ───────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
                onPressed: _safeNavigateBack,
                tooltip: 'العودة',
              ),
              Text(
                'مذبح القلب',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(width: 48), // Balance space
            ],
          ),

          const SizedBox(height: 16),

          Text(
            'ماذا ستقدم لله اليوم؟',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),

          const SizedBox(height: 32),

          // ── Commitment Type Selector ──────────────────────────────
          Text(
            'اختر نوع الالتزام',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 300.ms),

          const SizedBox(height: 12),

          CommitmentTypeSelector(
            selectedType: _selectedType,
            onTypeSelected: (type) {
              setState(() => _selectedType = type);
            },
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 400.ms)
              .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

          const SizedBox(height: 28),

          // ── Preset Suggestions ────────────────────────────────────
          Text(
            'أو اختر من الاقتراحات',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white70,
                ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 500.ms),

          const SizedBox(height: 12),

          CommitmentPresetChips(
            onPresetSelected: (preset) {
              _descriptionController.text = preset;
            },
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 600.ms),

          const SizedBox(height: 28),

          // ── Custom Description Input ──────────────────────────────
          Text(
            'اكتب التزامك',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 700.ms),

          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: TextField(
              controller: _descriptionController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                hintText: 'مثلاً: سأخصص ١٠ دقائق للصلاة الصامتة...',
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(color: Colors.white38),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                filled: false, // Override global theme to prevent white background
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 800.ms),

          const SizedBox(height: 32),

          // ── Submit Button ─────────────────────────────────────────
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitCommitment,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🔥', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 8),
                        Text(
                          'أقدم هذا لله',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 1000.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          // ── Core Logic Reminder ───────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white54, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'بدون تقديم التزامك اليوم، لن يتم احتساب اليوم مكتملًا ولن تنمو شجرة علاقتك بالله.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 1100.ms),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Already Committed View ─────────────────────────────────────────────
class _AlreadyCommittedView extends ConsumerWidget {
  const _AlreadyCommittedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('✅', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            Text(
              'لقد قدمت التزامك اليوم!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'شجرة علاقتك بالله تنمو.\nعد غدًا لالتزام جديد.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      ref.read(navigationIndexProvider.notifier).state = 0;
                    }
                  },
                  icon: const Icon(Icons.home, color: Colors.white, size: 18),
                  label: const Text('الرئيسية'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                    ref.read(navigationIndexProvider.notifier).state = 2;
                  },
                  icon: const Text('🌱', style: TextStyle(fontSize: 18)),
                  label: const Text('رؤية النمو'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.growthGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

