// ─── features/challenge/presentation/screens/challenge_day_detail_screen.dart
// Daily Companion (رفيق يومي) — Challenge day detail & journal entry
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/challenge_day.dart';

class ChallengeDayDetailScreen extends StatefulWidget {
  final ChallengeDay day;
  final ValueChanged<String?> onComplete;

  const ChallengeDayDetailScreen({
    super.key,
    required this.day,
    required this.onComplete,
  });

  @override
  State<ChallengeDayDetailScreen> createState() =>
      _ChallengeDayDetailScreenState();
}

class _ChallengeDayDetailScreenState extends State<ChallengeDayDetailScreen> {
  final TextEditingController _journalController = TextEditingController();
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.day.isCompleted;
    if (widget.day.userJournalEntry != null) {
      _journalController.text = widget.day.userJournalEntry!;
    }
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  void _completeDay() {
    setState(() => _isCompleted = true);
    widget.onComplete(
      _journalController.text.trim().isEmpty ? null : _journalController.text.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 أحسنت! تم إكمال اليوم ${widget.day.dayNumber}'),
        backgroundColor: AppTheme.growthGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isCompleted
                ? [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)]
                : [const Color(0xFFFFF8E7), const Color(0xFFF5E6CC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Custom App Bar ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    if (_isCompleted)
                      const Chip(
                        label: Text('✅ مكتمل'),
                        backgroundColor: AppTheme.growthGreen,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              ),

              // ── Content ─────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Day badge
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'اليوم ${widget.day.dayNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 400.ms),

                      const SizedBox(height: 24),

                      // Title
                      Text(
                        widget.day.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 200.ms),

                      const SizedBox(height: 8),

                      // Topic badge
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.day.topic,
                            style: TextStyle(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Verse Card ──────────────────────────────────
                      if (widget.day.bibleVerse.isNotEmpty)
                        _VerseCard(verse: widget.day.bibleVerse)
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 400.ms),

                      const SizedBox(height: 24),

                      // ── Action Item ─────────────────────────────────
                      _ActionCard(action: widget.day.actionItem)
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 600.ms),

                      const SizedBox(height: 24),

                      // ── Reflection Prompt ───────────────────────────
                      _ReflectionCard(prompt: widget.day.reflectionPrompt)
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 800.ms),

                      const SizedBox(height: 28),

                      // ── Journal Entry ───────────────────────────────
                      Text(
                        'يومياتك الروحية',
                        style: Theme.of(context).textTheme.labelLarge,
                        textDirection: TextDirection.rtl,
                      )
                          .animate()
                          .fadeIn(duration: 400.ms, delay: 1000.ms),

                      const SizedBox(height: 12),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _journalController,
                          maxLines: 5,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'اكتب تأملاتك ومشاعرك حول هذا الدرس...',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 1100.ms),

                      const SizedBox(height: 28),

                      // ── Complete Button ─────────────────────────────
                      if (!_isCompleted)
                        SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _completeDay,
                            icon: const Text('✅', style: TextStyle(fontSize: 20)),
                            label: const Text(
                              'أكملت هذا الدرس',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.growthGreen,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 1300.ms)
                            .slideY(begin: 0.2, end: 0),

                      if (_isCompleted)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.growthGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.growthGreen.withOpacity(0.3),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('🌿', style: TextStyle(fontSize: 24)),
                              SizedBox(width: 12),
                              Text(
                                'تم إكمال هذا اليوم! انتقل لليوم التالي.',
                                style: TextStyle(
                                  color: AppTheme.growthGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 1300.ms),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Verse Card ────────────────────────────────────────────────────────
class _VerseCard extends StatelessWidget {
  final String verse;

  const _VerseCard({required this.verse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentColor.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.divineLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('📖', style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              verse,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18,
                height: 1.6,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Action Card ───────────────────────────────────────────────────────
class _ActionCard extends StatelessWidget {
  final String action;

  const _ActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text('🎯', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مهمة اليوم',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  action,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
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

// ─── Reflection Card ───────────────────────────────────────────────────
class _ReflectionCard extends StatelessWidget {
  final String prompt;

  const _ReflectionCard({required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accentColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Text('💭', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'تأمل',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  prompt,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 15,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
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
