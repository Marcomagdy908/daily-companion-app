// ─── features/curriculum/data/curriculum_data.dart ─────────────────────
// Daily Companion (رفيق يومي) — Full curriculum content (المنهج كامل)
//
// This is the static source of truth for the "المنهج" section. Content
// is organized as: Section (pillar) → Group (sub-topic) → Card.
// ────────────────────────────────────────────────────────────────────────

import '../../../models/curriculum_card.dart';

const String curriculumIntro =
    'ربنا دايمًا بيحبنا، لذلك هو اللي بدأ العلاقة مع البشر. ربنا هو القوة '
    'المانحة اللي منحتنا الوجود والمواهب، ومستعد دايمًا يستجيب لصلواتنا '
    'ويعمل لأجلنا، لكن لازم نشترك معاه في العمل.';

final List<CurriculumSection> curriculumSections = [
  // ── 1. علاقة الله بالإنسان ─────────────────────────────────────────
  const CurriculumSection(
    id: 'god_to_man',
    title: 'علاقة الله بالإنسان',
    icon: '❤️',
    groups: [
      CurriculumGroup(cards: [
        CurriculumCard(
          id: 'g1c1',
          front: 'قصة حب',
          back: 'ازاي علاقتك بربنا بتحس إنها قصة حب؟',
        ),
        CurriculumCard(
          id: 'g1c2',
          front: 'عطاء',
          back: 'إيه أكتر حاجة حسيت إن ربنا اداهالك من غير ما تستاهلها؟',
        ),
        CurriculumCard(
          id: 'g1c3',
          front: 'عهد بين الله والناس',
          back: 'إيه معنى إن ربنا داخل معاك في عهد؟',
        ),
        CurriculumCard(
          id: 'g1c4',
          front: 'إله الضعفاء',
          back: 'امتى حسيت إن ربنا قريب منك في وقت ضعفك؟',
        ),
        CurriculumCard(
          id: 'g1c5',
          front: 'إلهنا الطيب',
          back: 'إيه اللي بيخليك متأكد إن ربنا طيب معاك؟',
        ),
        CurriculumCard(
          id: 'g1c6',
          front: 'الله المؤدب الشافي',
          back: 'إيه الفرق بين تأديب ربنا وعقاب الناس؟',
        ),
      ]),
    ],
  ),

  // ── 2. علاقة الإنسان بالله ─────────────────────────────────────────
  const CurriculumSection(
    id: 'man_to_god',
    title: 'علاقة الإنسان بالله',
    icon: '🙏',
    groups: [
      CurriculumGroup(cards: [
        CurriculumCard(
          id: 'g2c1',
          front: 'مركز الله في حياتنا (الحياة الروحية)',
          back: 'لو رسمت دايرة حياتك دلوقتي، ربنا فين موجود فيها؟',
        ),
        CurriculumCard(
          id: 'g2c2',
          front: 'لا شيء إلا بجانب الله (ربنا الكل في الكل)',
          back: 'إيه المعنى اللي بتفهمه من إن ربنا "الكل في الكل"؟',
        ),
        CurriculumCard(
          id: 'g2c3',
          front: 'كلمة الله إليك (رسالة ربنا ليك)',
          back: 'لو ربنا بعتلك رسالة النهارده، تفتكر هيقولك إيه؟',
        ),
        CurriculumCard(
          id: 'g2c4',
          front: 'معرفتنا لله (العشرة مع ربنا)',
          back: 'إيه الفرق بين إنك تعرف عن ربنا وإنك تعرفه شخصيًا؟',
        ),
      ]),
    ],
  ),

  // ── 3. الإنسان تاج الخليقة ────────────────────────────────────────
  const CurriculumSection(
    id: 'man_crown',
    title: 'الإنسان تاج الخليقة',
    icon: '👑',
    groups: [
      CurriculumGroup(
        title: 'أولاً: الإنسان — القيمة والجوهر',
        cards: [
          CurriculumCard(
            id: 'g3c1',
            front: 'ازاي ربنا شايف قيمة الإنسان؟',
            back: '',
            isQuestion: true,
          ),
          CurriculumCard(
            id: 'g3c2',
            front: 'ازاي احنا شايفين قيمتنا؟',
            back: '',
            isQuestion: true,
          ),
          CurriculumCard(
            id: 'g3c3',
            front: 'ازاي بتأثر حياتنا المسيحية على نظرتنا لقيمة الإنسان؟',
            back: '',
            isQuestion: true,
          ),
        ],
      ),
      CurriculumGroup(
        title: 'ثانياً: الإنسان — الشخص',
        cards: [
          CurriculumCard(
            id: 'g3c4',
            front: 'مفهوم الشخص',
            back: 'لو حد سألك "الشخص" يعني إيه في المسيحية، هتجاوب إزاي؟',
          ),
          CurriculumCard(
            id: 'g3c5',
            front: 'أنا أساوي كام؟',
            back: '',
            isQuestion: true,
          ),
          CurriculumCard(
            id: 'g3c6',
            front: 'تشييء الشخص (الشخص والشيء)',
            back: 'إيه الفرق بين إنك تتعامل مع حد كـ"شخص" أو كـ"شيء"؟',
          ),
          CurriculumCard(
            id: 'g3c7',
            front: 'الشخص: رؤية مسيحية (العهد القديم والعهد الجديد)',
            back: 'إيه اللي بيميز نظرة الكتاب المقدس بعهديه لقيمة الشخص؟',
          ),
        ],
      ),
      CurriculumGroup(
        title: 'ثالثاً: المسيحي والالتزام',
        cards: [
          CurriculumCard(
            id: 'g3c8',
            front: 'الالتزام والنضج الروحي',
            back: 'إيه العلاقة بين التزامك ونموك الروحي؟',
          ),
        ],
      ),
      CurriculumGroup(
        cards: [
          CurriculumCard(
            id: 'g3c9',
            front: 'الإنسان كائن حي (مش معنى كده ألغى مشيئة ربنا)',
            back: 'إزاي تفهم حريتك كـ"كائن حي" في ضوء مشيئة ربنا من غير ما '
                'تلغي حاجة من الاتنين؟',
          ),
        ],
      ),
    ],
  ),

  // ── 4. مشيئة ربنا ────────────────────────────────────────────────
  const CurriculumSection(
    id: 'gods_will',
    title: 'مشيئة ربنا',
    icon: '🕊️',
    groups: [
      CurriculumGroup(
        title: 'أسباب ومعطلات استجابتنا لمشيئة ربنا',
        cards: [
          CurriculumCard(
            id: 'g4c1',
            front: 'الطموح الذاتي',
            back: 'إيه الطموح اللي ممكن يكون بيتعارض مع مشيئة ربنا في حياتك دلوقتي؟',
          ),
          CurriculumCard(
            id: 'g4c2',
            front: 'كلام الناس',
            back: 'امتى كلام الناس أثّر على قرار كان المفروض يبقى بينك وبين ربنا بس؟',
          ),
          CurriculumCard(
            id: 'g4c3',
            front: 'الاندفاع',
            back: 'إيه القرار اللي اتخذته باندفاع وكان محتاج وقت أكتر؟',
          ),
          CurriculumCard(
            id: 'g4c4',
            front: 'المفاوضات مع العدو',
            back: 'إيه شكل "المفاوضة" اللي بتحصل جوه دماغك قبل ما تسقط في تجربة؟',
          ),
          CurriculumCard(
            id: 'g4c5',
            front: 'الترف',
            back: 'هل فيه رفاهية في حياتك بتبعدك عن التسليم لمشيئة ربنا؟',
          ),
          CurriculumCard(
            id: 'g4c6',
            front: 'العقلانية',
            back: 'امتى حاولت تفهم كل حاجة بعقلك بدل ما تسلّم بالإيمان؟',
          ),
          CurriculumCard(
            id: 'g4c7',
            front: 'الخوف',
            back: 'إيه أكتر خوف بيمنعك من التسليم الكامل لربنا؟',
          ),
        ],
      ),
      CurriculumGroup(cards: [
        CurriculumCard(
          id: 'g4c8',
          front: 'احتياجنا الملح للتسليم',
          back: 'إيه اللي بيخليك حاسس إنك محتاج تسلّم حياتك لربنا دلوقتي بالذات؟',
        ),
        CurriculumCard(
          id: 'g4c9',
          front: 'الفرق بين التسليم الإرادي والأمر الواقع',
          back: 'إيه الفرق في حياتك بين إنك "تسلّم" باختيارك وإنك "تستسلم" '
              'لأنك مالكش حل تاني؟',
        ),
      ]),
      CurriculumGroup(
        title: 'أمور تسبق حياة التسليم',
        cards: [
          CurriculumCard(
            id: 'g4c10',
            front: 'التجرد من الرغبات',
            back: 'إيه الرغبة اللي محتاج تتجرد منها عشان تسلّم لربنا؟',
          ),
          CurriculumCard(
            id: 'g4c11',
            front: 'الاتضاع',
            back: 'إيه أقرب موقف حسيت فيه إنك محتاج تتواضع قدام ربنا؟',
          ),
          CurriculumCard(
            id: 'g4c12',
            front: 'الإيمان',
            back: 'إيه اللي بيقوّي إيمانك وقت ما بتكون محتاج تسلّم؟',
          ),
        ],
      ),
    ],
  ),

  // ── 5. القوى الإنسانية والمعالم الروحية ─────────────────────────────
  const CurriculumSection(
    id: 'human_powers',
    title: 'القوى الإنسانية والمعالم الروحية',
    icon: '⚖️',
    groups: [
      CurriculumGroup(
        title: 'أولاً: القوى الإنسانية',
        cards: [
          CurriculumCard(id: 'g5c1', front: 'الروح', back: 'إزاي روحك بتشارك في قراراتك؟'),
          CurriculumCard(id: 'g5c2', front: 'الضمير', back: 'امتى ضميرك وخزك في قرار اخدته؟'),
          CurriculumCard(id: 'g5c3', front: 'العقل', back: 'إزاي بتوازن بين عقلك وإيمانك وقت اتخاذ القرار؟'),
          CurriculumCard(id: 'g5c4', front: 'النفس', back: 'إزاي نفسك (رغباتك الداخلية) بتأثر على قراراتك؟'),
          CurriculumCard(id: 'g5c5', front: 'الغرائز', back: 'إمتى غرائزك كانت بتوجهك عكس اللي ربنا عايزه؟'),
          CurriculumCard(id: 'g5c6', front: 'العادات', back: 'فيه عادة بتأثر في طريقة اتخاذك للقرار من غير ما تاخد بالك؟'),
          CurriculumCard(id: 'g5c7', front: 'الاتجاهات', back: 'إيه الاتجاه (الميول) اللي بتلاحظه في نفسك في قراراتك الأخيرة؟'),
          CurriculumCard(id: 'g5c8', front: 'العواطف', back: 'إزاي عواطفك بتأثر على وضوح قرارك؟'),
          CurriculumCard(id: 'g5c9', front: 'الجسم', back: 'إزاي حالتك الجسدية بتأثر على قدرتك على اتخاذ قرار سليم؟'),
          CurriculumCard(id: 'g5c10', front: 'المجتمع', back: 'إزاي المجتمع حواليك بيأثر على قراراتك؟'),
        ],
      ),
      CurriculumGroup(
        title: 'ثانياً: المعالم الروحية',
        cards: [
          CurriculumCard(
            id: 'g5c11',
            front: 'الروح القدس',
            back: 'إزاي بتطلب إرشاد الروح القدس قبل قرار مهم؟',
          ),
          CurriculumCard(
            id: 'g5c12',
            front: 'الكتاب المقدس: نور وسراج',
            back: 'إمتى استخدمت كلمة ربنا كـ"نور" يوجهك في قرار محتار فيه؟',
          ),
          CurriculumCard(
            id: 'g5c13',
            front: 'الكنيسة وخبرة آبائها',
            back: 'هل بترجع لنصيحة أب اعتراف أو خبرة الكنيسة قبل قرارات مهمة؟',
          ),
          CurriculumCard(
            id: 'g5c14',
            front: 'الحوار',
            back: 'مع مين بتتحاور قبل ما تاخد قرار مصيري؟',
          ),
          CurriculumCard(
            id: 'g5c15',
            front: '"يفتح ولا أحد يغلق"',
            back: 'إزاي بتثق إن الباب اللي ربنا هيفتحه محدش هيقدر يقفله؟',
          ),
        ],
      ),
    ],
  ),
];
