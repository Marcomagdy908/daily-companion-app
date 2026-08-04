// ─── models/curriculum_card.dart ───────────────────────────────────────
// Daily Companion (رفيق يومي) — Full curriculum (المنهج) content model
//
// Plain local models (no Firestore / freezed) since this content ships
// with the app and never changes at runtime.
// ────────────────────────────────────────────────────────────────────────

/// A single flashcard. If [isQuestion] is true, the UI treats the back
/// as a personal-reflection prompt rather than an "answer" to reveal.
class CurriculumCard {
  final String id;
  final String front;
  final String back;
  final bool isQuestion;

  const CurriculumCard({
    required this.id,
    required this.front,
    required this.back,
    this.isQuestion = false,
  });
}

/// A named group of cards inside a section (e.g. "أولاً: الإنسان القيمة والجوهر").
/// [title] may be empty for sections with no sub-grouping.
class CurriculumGroup {
  final String title;
  final List<CurriculumCard> cards;

  const CurriculumGroup({
    this.title = '',
    required this.cards,
  });
}

/// One of the five top-level pillars of the curriculum.
class CurriculumSection {
  final String id;
  final String title;
  final String icon;
  final List<CurriculumGroup> groups;

  const CurriculumSection({
    required this.id,
    required this.title,
    required this.icon,
    required this.groups,
  });

  int get cardCount =>
      groups.fold(0, (sum, g) => sum + g.cards.length);
}
