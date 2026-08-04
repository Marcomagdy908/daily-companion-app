// ─── services/challenge_service.dart ───────────────────────────────────
// Daily Companion (رفيق يومي) — 30-Day Challenge service
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/challenge_day.dart';
import 'firebase_config.dart';

class ChallengeService {
  final FirebaseConfig _config = FirebaseConfig();

  /// Fetch all challenge days for a user
  Future<List<ChallengeDay>> fetchChallengeDays(String userId) async {
    final snapshot = await _config.challengesCollection
        .doc(userId)
        .collection('days')
        .orderBy('dayNumber')
        .get();

    if (snapshot.docs.isEmpty) {
      return _initializeChallenge(userId);
    }

    return snapshot.docs
        .map((doc) => ChallengeDay.fromJson(doc.data()))
        .toList();
  }

  /// Initialize 30-day challenge for a new user
  List<ChallengeDay> _initializeChallenge(String userId) {
    final days = _challengeContent();
    // Write to Firestore
    for (final day in days) {
      _config.challengesCollection
          .doc(userId)
          .collection('days')
          .doc('day_${day.dayNumber}')
          .set(day.toJson());
    }
    return days;
  }

  /// Mark a challenge day as completed (with journal entry)
  Future<void> completeDay({
    required String userId,
    required int dayNumber,
    String? journalEntry,
  }) async {
    await _config.challengesCollection
        .doc(userId)
        .collection('days')
        .doc('day_$dayNumber')
        .update({
      'isCompleted': true,
      'userJournalEntry': journalEntry ?? '',
      'completedAt': DateTime.now().toIso8601String(),
    });

    // Unlock the next day
    if (dayNumber < 30) {
      await _config.challengesCollection
          .doc(userId)
          .collection('days')
          .doc('day_${dayNumber + 1}')
          .update({'isUnlocked': true});
    }
  }

  /// Stream challenge days
  Stream<List<ChallengeDay>> watchChallengeDays(String userId) {
    return _config.challengesCollection
        .doc(userId)
        .collection('days')
        .orderBy('dayNumber')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return _initializeChallenge(userId);
      }
      return snapshot.docs
          .map((doc) => ChallengeDay.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get challenge progress percentage
  Future<double> fetchChallengeProgress(String userId) async {
    final days = await fetchChallengeDays(userId);
    if (days.isEmpty) return 0.0;
    final completed = days.where((d) => d.isCompleted).length;
    return completed / days.length;
  }

  /// ─── 30-Day Challenge Content (Arabic) ───────────────────────────────
  static List<ChallengeDay> _challengeContent() {
    final topics = [
      {
        'title': 'كيف أعطي الله وقتي الأول؟',
        'topic': 'الأولوية لله',
        'action': 'خصص أول 10 دقائق من يومك للصلاة الصامتة.',
        'verse': 'اَلْتَمِسُوا أَوَّلاً مَلَكُوتَ ٱللَّهِ وَبِرَّهُ',
        'reflection': 'هل تعطي الله أول وقتك أم بقية وقتك؟',
      },
      {
        'title': 'شكره في الضيق',
        'topic': 'الشكر',
        'action': 'اكتب 5 أشياء تشكر الله عليها رغم الظروف.',
        'verse': 'شَاكِرِينَ كُلَّ حِينٍ عَلَى كُلِّ شَيْءٍ',
        'reflection': 'كيف يمكن للشكر أن يغير نظرتك للضيق؟',
      },
      {
        'title': 'قراءة الكلمة يوميًا',
        'topic': 'الكتاب المقدس',
        'action': 'اقرأ إنجيل يوحنا الإصحاح الأول وتأمل فيه.',
        'verse': 'فِي ٱلْبَدْءِ كَانَ ٱلْكَلِمَةُ',
        'reflection': 'ما هي الكلمة التي يريد الله أن يقولها لك اليوم؟',
      },
      {
        'title': 'الصلاة من أجل الآخرين',
        'topic': 'الصلاة الشفاعية',
        'action': 'صلِّ من أجل 3 أشخاص محددين اليوم.',
        'verse': 'صَلُّوا بَعْضُكُمْ لِأَجْلِ بَعْضٍ',
        'reflection': 'كيف تشعر عندما تصلي من أجل غيرك؟',
      },
      {
        'title': 'الصوم والتركيز',
        'topic': 'الصوم',
        'action': 'اختر شيئًا واحدًا تصوم عنه اليوم (طعام/وسائل تواصل).',
        'verse': 'لَيْسَ بِٱلْخُبْزِ وَحْدَهُ يَحْيَا ٱلْإِنْسَانُ',
        'reflection': 'ما الذي يلهيك عن الله وتريد الصوم عنه؟',
      },
      {
        'title': 'خدمة المحتاج',
        'topic': 'الخدمة',
        'action': 'ابحث عن شخص محتاج اليوم وساعده بطريقة عملية.',
        'verse': 'أَحِبَّ قَرِيبَكَ كَنَفْسِكَ',
        'reflection': 'كيف ترى وجه المسيح في الشخص الذي تخدمه؟',
      },
      {
        'title': 'التسبيح والترنيم',
        'topic': 'التسبيح',
        'action': 'رنم ترنيمة أو مزمورًا من قلبك لله اليوم.',
        'verse': 'أُرَنِّمُ لِلرَّبِّ فِي حَيَاتِي',
        'reflection': 'كيف يغير التسبيح مزاجك ونظرتك؟',
      },
      {
        'title': 'الغفران',
        'topic': 'الغفران',
        'action': 'سامح شخصًا أساء إليك ولو برسالة أو في قلبك.',
        'verse': 'ٱغْفِرُوا يُغْفَرْ لَكُمْ',
        'reflection': 'من الذي تحتاج أن تسامحه اليوم؟',
      },
      {
        'title': 'الصمت والتأمل',
        'topic': 'التأمل',
        'action': 'اقضِ 15 دقيقة في صمت تام تستمع لصوت الله.',
        'verse': 'اُسْكُتْ وَٱعْلَمْ أَنِّي أَنَا ٱللهُ',
        'reflection': 'ماذا تسمع عندما تصمت؟',
      },
      {
        'title': 'العطاء بسخاء',
        'topic': 'العطاء',
        'action': 'تبرع بشيء ذي قيمة لشخص لا تعرفه.',
        'verse': 'اَلْمُعْطِي ٱلْمَسْرُورَ يُحِبُّهُ ٱللهُ',
        'reflection': 'هل تعطي مما فاض عنك أم من احتياجك؟',
      },
      {
        'title': 'الشهادة للإيمان',
        'topic': 'الشهادة',
        'action': 'شارك قصة إيمانك مع شخص جديد اليوم.',
        'verse': 'فَٱذْهَبُوا وَتَلْمِذُوا جَمِيعَ ٱلْأُمَمِ',
        'reflection': 'من الذي يحتاج أن يسمع قصتك مع الله؟',
      },
      {
        'title': 'التواضع',
        'topic': 'التواضع',
        'action': 'قم بعمل بسيط في الخفاء دون أن يعلم به أحد.',
        'verse': 'اَللهُ يُقَاوِمُ ٱلْمُسْتَكْبِرِينَ',
        'reflection': 'متى كانت آخر مرة فعلت فيها خيرًا في الخفاء؟',
      },
      {
        'title': 'الثقة في تدبير الله',
        'topic': 'الثقة',
        'action': 'سلم أمرًا يقلقك لله واكتب صلاة تسليم.',
        'verse': 'أَلْقُوا كُلَّ هَمِّكُمْ عَلَيْهِ',
        'reflection': 'ما هو الهم الذي تريد أن تلقيه على الله اليوم؟',
      },
      {
        'title': 'محبة الأعداء',
        'topic': 'المحبة',
        'action': 'صلِّ من أجل شخص لا تحبه أو يضايقك.',
        'verse': 'أَحِبُّوا أَعْدَاءَكُمْ',
        'reflection': 'كيف تغير الصلاة من أجل العدو قلبك؟',
      },
      {
        'title': 'الاتضاع أمام الله',
        'topic': 'الاتضاع',
        'action': 'اركع في صلاتك اليوم واعترف بعظمته.',
        'verse': 'طُوبَى لِلْمَسَاكِينِ بِٱلرُّوحِ',
        'reflection': 'كيف تشعر بالاتضاع الحقيقي أمام عظمة الله؟',
      },
      {
        'title': 'الرجاء في المواعيد',
        'topic': 'الرجاء',
        'action': 'اكتب 3 وعود من الكتاب وتمسك بها اليوم.',
        'verse': 'لِأَنَّ لِي أَفْكَارَ سَلَامٍ لَا شَرٍّ',
        'reflection': 'أي وعد إلهي تحتاج أن تتمسك به اليوم؟',
      },
      {
        'title': 'الصبر والتأني',
        'topic': 'الصبر',
        'action': 'تدرب على الصبر في موقف صعب اليوم.',
        'verse': 'بِصَبْرِكُمُ ٱقْتَنُوا نُفُوسَكُمْ',
        'reflection': 'في أي مجال تحتاج المزيد من الصبر؟',
      },
      {
        'title': 'الفرح الروحي',
        'topic': 'الفرح',
        'action': 'ابحث عن سبب للفرح رغم الظروف وشاركه.',
        'verse': 'فَرَحُ ٱلرَّبِّ هُوَ قُوَّتُكُمْ',
        'reflection': 'هل فرحك يعتمد على الظروف أم على الله؟',
      },
      {
        'title': 'السلام الداخلي',
        'topic': 'السلام',
        'action': 'مارس التنفس العميق مع ترديد "سلامي أترك لكم".',
        'verse': 'سَلَامًا أَتْرُكُ لَكُمْ',
        'reflection': 'كيف تحافظ على سلامك الداخلي في الفوضى؟',
      },
      {
        'title': 'الإيمان العملي',
        'topic': 'الإيمان',
        'action': 'خطِّ خطوة إيمان عملية في مجال تخاف منه.',
        'verse': 'ٱلْإِيمَانُ بِدُونِ أَعْمَالٍ مَيِّتٌ',
        'reflection': 'ما هي خطوة الإيمان التي تؤجلها؟',
      },
      {
        'title': 'الحكمة الإلهية',
        'topic': 'الحكمة',
        'action': 'اقرأ سفر الأمثال إصحاحًا واحدًا وتأمل.',
        'verse': 'إِنْ كَانَ أَحَدُكُمْ تُعْوِزُهُ حِكْمَةٌ',
        'reflection': 'في أي قرار تحتاج حكمة من الله؟',
      },
      {
        'title': 'الوحدة مع المسيح',
        'topic': 'الوحدة',
        'action': 'تأمل في معنى "المسيح فيَّ وأنا فيه" لمدة 10 دقائق.',
        'verse': 'أَنَا ٱلْكَرْمَةُ وَأَنْتُمُ ٱلْأَغْصَانُ',
        'reflection': 'كيف تعيش الاتحاد الحقيقي بالمسيح يوميًا؟',
      },
      {
        'title': 'نقاوة القلب',
        'topic': 'النقاوة',
        'action': 'افحص قلبك واعترف بأي خطية خفية في صلاتك.',
        'verse': 'طُوبَى لِأَنْقِيَاءِ ٱلْقَلْبِ',
        'reflection': 'هل هناك شيء في قلبك يحتاج تطهيرًا؟',
      },
      {
        'title': 'الأمانة في القليل',
        'topic': 'الأمانة',
        'action': 'كن أمينًا في مهمة صغيرة أو عهد صغير اليوم.',
        'verse': 'اَلْأَمِينُ فِي ٱلْقَلِيلِ',
        'reflection': 'كيف تكافئك الأمانة في الصغير؟',
      },
      {
        'title': 'الرجوع عن الضلال',
        'topic': 'التوبة',
        'action': 'حدد عادة سيئة واحدة وابدأ في تركها اليوم.',
        'verse': 'اِرْجِعُوا إِلَيَّ أَرْجِعْ إِلَيْكُمْ',
        'reflection': 'ما الذي يبعدك عن الله وتريد الرجوع عنه؟',
      },
      {
        'title': 'القيادة الروحية',
        'topic': 'القيادة',
        'action': 'شجع شخصًا أصغر منك في الإيمان اليوم.',
        'verse': 'كُونُوا مُتَمَثِّلِينَ بِي',
        'reflection': 'من هو الشخص الذي تقوده روحيًا؟',
      },
      {
        'title': 'قوة الكلمة',
        'topic': 'الكلمة',
        'action': 'احفظ آية اليوم عن ظهر قلب ورددها.',
        'verse': 'كَلِمَتُكَ مِصْبَاحٌ لِرِجْلِي',
        'reflection': 'كيف أنارت الكلمة طريقك في الظلمة؟',
      },
      {
        'title': 'الشركة الروحية',
        'topic': 'الشركة',
        'action': 'تواصل مع أخ/أخت في الإيمان وشاركه تأمل اليوم.',
        'verse': 'حَيْثُمَا ٱجْتَمَعَ ٱثْنَانِ أَوْ ثَلَاثَةٌ',
        'reflection': 'لماذا نحتاج الشركة الروحية في مسيرتنا؟',
      },
      {
        'title': 'الاستعداد للأبدية',
        'topic': 'الأبدية',
        'action': 'تأمل في الحياة الأبدية واكتب ما تعنيه لك.',
        'verse': 'أَنَا هُوَ ٱلْقِيَامَةُ وَٱلْحَيَاةُ',
        'reflection': 'كيف تستعد للحياة الأبدية كل يوم؟',
      },
      {
        'title': 'الالتزام والثبات',
        'topic': 'الثبات',
        'action': 'لخص رحلتك في الـ30 يومًا واكتب التزامك المستقبلي.',
        'verse': 'ثَابِتِينَ رَاسِخِينَ فِي ٱلْإِيمَانِ',
        'reflection': 'ما هو التزامك الروحي بعد هذه الرحلة؟',
      },
    ];

    return List.generate(30, (i) {
      final t = topics[i];
      return ChallengeDay(
        dayNumber: i + 1,
        title: t['title']!,
        description: 'اليوم ${i + 1} من رحلتك الروحية. ${t['reflection']!}',
        topic: t['topic']!,
        reflectionPrompt: t['reflection']!,
        actionItem: t['action']!,
        bibleVerse: t['verse']!,
        isUnlocked: i == 0, // Only day 1 is unlocked initially
        isCompleted: false,
      );
    });
  }
}
