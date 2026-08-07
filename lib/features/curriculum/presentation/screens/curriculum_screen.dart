// ─── features/curriculum/presentation/screens/curriculum_screen.dart ───
// Daily Companion (رفيق يومي) — المنهج كامل: Full curriculum section
//
// Independent from the Daily Lock flow. Shows the 5 pillars as an
// accordion; each pillar opens a flashcard browser covering every
// point in that pillar.
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/curriculum_card.dart';
import '../../data/curriculum_data.dart';
import '../widgets/flip_flashcard.dart';

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  String? _expandedSectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المنهج')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _IntroBanner(text: curriculumIntro),
          const SizedBox(height: 16),
          ...curriculumSections.map((section) {
            final isExpanded = _expandedSectionId == section.id;
            return _SectionAccordion(
              section: section,
              isExpanded: isExpanded,
              onToggle: () => setState(() {
                _expandedSectionId = isExpanded ? null : section.id;
              }),
            );
          }),
        ],
      ),
    );
  }
}

class _IntroBanner extends StatelessWidget {
  final String text;
  const _IntroBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.curriculumPurple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.curriculumPurple.withOpacity(0.2)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 15,
          height: 1.8,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }
}

class _SectionAccordion extends StatelessWidget {
  final CurriculumSection section;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _SectionAccordion({
    required this.section,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(section.icon, style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.curriculumPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${section.cardCount}',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.curriculumPurple,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: _GroupsList(groups: section.groups),
            crossFadeState:
                isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 220),
          ),
        ],
      ),
    );
  }
}

class _GroupsList extends StatelessWidget {
  final List<CurriculumGroup> groups;
  const _GroupsList({required this.groups});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final group in groups) ...[
            if (group.title.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                group.title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.curriculumPurple,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: group.cards
                  .map((card) => _CardChip(
                        card: card,
                        allCardsInGroup: group.cards,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

class _CardChip extends StatelessWidget {
  final CurriculumCard card;
  final List<CurriculumCard> allCardsInGroup;

  const _CardChip({required this.card, required this.allCardsInGroup});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _openBrowser(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: card.isQuestion
              ? AppTheme.divineLight
              : AppTheme.curriculumPurple.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: card.isQuestion
                ? AppTheme.accentColor.withOpacity(0.4)
                : AppTheme.curriculumPurple.withOpacity(0.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(card.isQuestion ? '💭' : '🔖', style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 220),
              child: Text(
                card.chipLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openBrowser(BuildContext context) {
    final startIndex = allCardsInGroup.indexWhere((c) => c.id == card.id);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FlashcardBrowserSheet(
        cards: allCardsInGroup,
        initialIndex: startIndex < 0 ? 0 : startIndex,
      ),
    );
  }
}

class _FlashcardBrowserSheet extends StatefulWidget {
  final List<CurriculumCard> cards;
  final int initialIndex;

  const _FlashcardBrowserSheet({required this.cards, required this.initialIndex});

  @override
  State<_FlashcardBrowserSheet> createState() => _FlashcardBrowserSheetState();
}

class _FlashcardBrowserSheetState extends State<_FlashcardBrowserSheet> {
  late final PageController _pageController;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.68,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${_index + 1} من ${widget.cards.length}',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.cards.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: FlipFlashcard(card: widget.cards[i]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.cards.length, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _index ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _index
                          ? AppTheme.curriculumPurple
                          : AppTheme.curriculumPurple.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
