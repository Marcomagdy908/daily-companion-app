// ─── services/challenge_service.dart ───────────────────────────────────
// Daily Companion (رفيق يومي) — 30-Day Challenge service (Local Storage)
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/challenge_day.dart';

class ChallengeService {
  String _key(String userId) => 'challenge_days_$userId';

  /// Fetch all challenge days for a user
  Future<List<ChallengeDay>> fetchChallengeDays(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key(userId));

    if (jsonStr == null || jsonStr.isEmpty) {
      return _initializeChallenge(userId);
    }

    try {
      final List<dynamic> rawList = jsonDecode(jsonStr);
      final days = rawList.map((item) => ChallengeDay.fromJson(item as Map<String, dynamic>)).toList();
      days.sort((a, b) => a.dayNumber.compareTo(b.dayNumber));
      return days;
    } catch (_) {
      return _initializeChallenge(userId);
    }
  }

  /// Initialize 30-day challenge for a new user
  Future<List<ChallengeDay>> _initializeChallenge(String userId) async {
    final days = _challengeContent();
    await _saveDays(userId, days);
    return days;
  }

  Future<void> _saveDays(String userId, List<ChallengeDay> days) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(days.map((d) => d.toJson()).toList());
    await prefs.setString(_key(userId), jsonStr);
  }

  /// Mark a challenge day as completed (with journal entry)
  Future<void> completeDay({
    required String userId,
    required int dayNumber,
    String? journalEntry,
  }) async {
    final days = await fetchChallengeDays(userId);
    final updatedDays = days.map((day) {
      if (day.dayNumber == dayNumber) {
        return day.copyWith(
          isCompleted: true,
          userJournalEntry: journalEntry ?? '',
          completedAt: DateTime.now(),
        );
      } else if (day.dayNumber == dayNumber + 1) {
        return day.copyWith(isUnlocked: true);
      }
      return day;
    }).toList();

    await _saveDays(userId, updatedDays);
  }

  /// Stream challenge days
  Stream<List<ChallengeDay>> watchChallengeDays(String userId) async* {
    yield await fetchChallengeDays(userId);
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
        'verse': '«اَلْتَمِسُوا أَوَّلاً مَلَكُوتَ ٱللَّهِ وَبِرَّهُ، وَهذِهِ كُلُّهَا تُزَادُ لَكُمْ.» (متى 6: 33)',
        'reflection': 'هل تعطي الله أول وقتك أم بقية وقتك؟',
      },
      {
        'title': 'شكره في الضيق',
        'topic': 'الشكر',
        'action': 'اكتب 5 أشياء تشكر الله عليها رغم الظروف.',
        'verse': '«شَاكِرِينَ كُلَّ حِينٍ عَلَى كُلِّ شَيْءٍ فِي اسْمِ رَبِّنَا يَسُوعَ الْمَسِيحِ.» (أفسس 5: 20)',
        'reflection': 'كيف يمكن للشكر أن يغير نظرتك للضيق؟',
      },
      {
        'title': 'قراءة الكلمة يوميًا',
        'topic': 'الكتاب المقدس',
        'action': 'اقرأ إنجيل يوحنا الإصحاح الأول وتأمل فيه.',
        'verse': '«فِي ٱلْبَدْءِ كَانَ ٱلْكَلِمَةُ، وَٱلْكَلِمَةُ كَانَ عِنْدَ ٱللَّهِ، وَكَانَ ٱلْكَلِمَةُ ٱللَّهَ.» (يوحنا 1: 1)',
        'reflection': 'ما هي الكلمة التي يريد الله أن يقولها لك اليوم؟',
      },
      {
        'title': 'الصلاة من أجل الآخرين',
        'topic': 'الصلاة الشفاعية',
        'action': 'صلِّ من أجل 3 أشخاص محددين اليوم.',
        'verse': '«صَلُّوا بَعْضُكُمْ لِأَجْلِ بَعْضٍ لِكَيْ تُشْفَوْا.» (يعقوب 5: 16)',
        'reflection': 'كيف تشعر عندما تصلي من أجل غيرك؟',
      },
      {
        'title': 'الصوم والتركيز',
        'topic': 'الصوم',
        'action': 'اختر شيئًا واحدًا تصوم عنه اليوم (طعام/وسائل تواصل).',
        'verse': '«لَيْسَ بِٱلْخُبْزِ وَحْدَهُ يَحْيَا ٱلْإِنْسَانُ، بَلْ بِكُلِّ كَلِمَةٍ تَخْرُجُ مِنْ فَمِ ٱللَّهِ.» (متى 4: 4)',
        'reflection': 'ما الذي يلهيك عن الله وتريد الصوم عنه؟',
      },
      {
        'title': 'خدمة المحتاج',
        'topic': 'الخدمة',
        'action': 'ابحث عن شخص محتاج اليوم وساعده بطريقة عملية.',
        'verse': '«أَحِبَّ قَرِيبَكَ كَنَفْسِكَ.» (متى 22: 39)',
        'reflection': 'كيف ترى وجه المسيح في الشخص الذي تخدمه؟',
      },
      {
        'title': 'التسبيح والترنيم',
        'topic': 'التسبيح',
        'action': 'رنم ترنيمة أو مزمورًا من قلبك لله اليوم.',
        'verse': '«أُرَنِّمُ لِلرَّبِّ فِي حَيَاتِي. أُزَمِّرُ لإِلهِي مَا دُمْتُ مَوْجُودًا.» (مزمور 104: 33)',
        'reflection': 'كيف يغير التسبيح مزاجك ونظرتك؟',
      },
      {
        'title': 'الغفران',
        'topic': 'الغفران',
        'action': 'سامح شخصًا أساء إليك ولو برسالة أو في قلبك.',
        'verse': '«اغْفِرُوا يُغْفَرْ لَكُمْ.» (لوقا 6: 37)',
        'reflection': 'من الذي تحتاج أن تسامحه اليوم؟',
      },
      {
        'title': 'الصمت والتأمل',
        'topic': 'التأمل',
        'action': 'اقضِ 15 دقيقة في صمت تام تستمع لصوت الله.',
        'verse': '«اُسْكُتُوا وَاعْلَمُوا أَنِّي أَنَا اللهُ.» (مزمور 46: 10)',
        'reflection': 'ماذا تسمع عندما تصمت؟',
      },
      {
        'title': 'العطاء بسخاء',
        'topic': 'العطاء',
        'action': 'تبرع بشيء ذي قيمة لشخص لا تعرفه.',
        'verse': '«المُعْطِيَ الْمَسْرُورَ يُحِبُّهُ اللهُ.» (2 كورنثوس 9: 7)',
        'reflection': 'هل تعطي مما فاض عنك أم من احتياجك؟',
      },
      {
        'title': 'الشهادة للإيمان',
        'topic': 'الشهادة',
        'action': 'شارك قصة إيمانك مع شخص جديد اليوم.',
        'verse': '«فَاذْهَبُوا وَتَلْمِذُوا جَمِيعَ الأُمَمِ وَعَمِّدُوهُمْ.» (متى 28: 19)',
        'reflection': 'من الذي يحتاج أن يسمع قصتك مع الله؟',
      },
      {
        'title': 'التواضع',
        'topic': 'التواضع',
        'action': 'قم بعمل بسيط في الخفاء دون أن يعلم به أحد.',
        'verse': '«اللهُ يُقَاوِمُ الْمُسْتَكْبِرِينَ، وَأَمَّا الْمُتَوَاضِعُونَ فَيُعْطِيهِمْ نِعْمَةً.» (يعقوب 4: 6)',
        'reflection': 'متى كانت آخر مرة فعلت فيها خيرًا في الخفاء؟',
      },
      {
        'title': 'الثقة في تدبير الله',
        'topic': 'الثقة',
        'action': 'سلم أمرًا يقلقك لله واكتب صلاة تسليم.',
        'verse': '«مُلْقِينَ كُلَّ هَمِّكُمْ عَلَيْهِ، لأَنَّهُ هُوَ يَعْتَنِي بِكُمْ.» (1 بطرس 5: 7)',
        'reflection': 'ما هو الهم الذي تريد أن تلقيه على الله اليوم؟',
      },
      {
        'title': 'محبة الأعداء',
        'topic': 'المحبة',
        'action': 'صلِّ من أجل شخص لا تحبه أو يضايقك.',
        'verse': '«أَحِبُّوا أَعْدَاءَكُمْ. بَارِكُوا لاَعِنِيكُمْ. أَحْسِنُوا إِلَى مُبْغِضِيكُمْ.» (متى 5: 44)',
        'reflection': 'كيف تغير الصلاة من أجل العدو قلبك؟',
      },
      {
        'title': 'الاتضاع أمام الله',
        'topic': 'الاتضاع',
        'action': 'اركع في صلاتك اليوم واعترف بعظمته.',
        'verse': '«طُوبَى لِلْمَسَاكِينِ بِالرُّوحِ، لأَنَّ لَهُمْ مَلَكُوتَ السَّمَاوَاتِ.» (متى 5: 3)',
        'reflection': 'كيف تشعر بالاتضاع الحقيقي أمام عظمة الله؟',
      },
      {
        'title': 'الرجاء في المواعيد',
        'topic': 'الرجاء',
        'action': 'اكتب 3 وعود من الكتاب وتمسك بها اليوم.',
        'verse': '«لأَنِّي عَرَفْتُ الأَفْكَارَ الَّتِي أَنَا مُفَكِّرٌ بِهَا عَنْكُمْ، يَقُولُ الرَّبُّ، أَفْكَارَ سَلاَمٍ لاَ شَرٍّ.» (إرميا 29: 11)',
        'reflection': 'أي وعد إلهي تحتاج أن تتمسك به اليوم؟',
      },
      {
        'title': 'الصبر والتأني',
        'topic': 'الصبر',
        'action': 'تدرب على الصبر في موقف صعب اليوم.',
        'verse': '«بِصَبْرِكُمُ اقْتَنُوا أَنْفُسَكُمْ.» (لوقا 21: 19)',
        'reflection': 'في أي مجال تحتاج المزيد من الصبر؟',
      },
      {
        'title': 'الفرح الروحي',
        'topic': 'الفرح',
        'action': 'ابحث عن سبب للفرح رغم الظروف وشاركه.',
        'verse': '«فَرَحُ الرَّبِّ هُوَ قُوَّتُكُمْ.» (نحميا 8: 10)',
        'reflection': 'هل فرحك يعتمد على الظروف أم على الله؟',
      },
      {
        'title': 'السلام الداخلي',
        'topic': 'السلام',
        'action': 'مارس التنفس العميق مع ترديد "سلامي أترك لكم".',
        'verse': '«سَلاَمًا أَتْرُكُ لَكُمْ. سَلاَمِي أُعْطِيكُمْ.» (يوحنا 14: 27)',
        'reflection': 'كيف تحافظ على سلامك الداخلي في الفوضى؟',
      },
      {
        'title': 'الإيمان العملي',
        'topic': 'الإيمان',
        'action': 'خطِّ خطوة إيمان عملية في مجال تخاف منه.',
        'verse': '«الإِيمَانُ بِدُونِ أَعْمَالٍ مَيِّتٌ.» (يعقوب 2: 20)',
        'reflection': 'ما هي خطوة الإيمان التي تؤجلها؟',
      },
      {
        'title': 'الحكمة الإلهية',
        'topic': 'الحكمة',
        'action': 'اقرأ سفر الأمثال إصحاحًا واحدًا وتأمل.',
        'verse': '«إِنْ كَانَ أَحَدُكُمْ تُعْوِزُهُ حِكْمَةٌ، فَلْيَطْلُبْ مِنَ اللهِ الَّذِي يُعْطِي الْجَمِيعَ بِسَخَاءٍ.» (يعقوب 1: 5)',
        'reflection': 'في أي قرار تحتاج حكمة من الله؟',
      },
      {
        'title': 'الوحدة مع المسيح',
        'topic': 'الوحدة',
        'action': 'تأمل في معنى "المسيح فيَّ وأنا فيه" لمدة 10 دقائق.',
        'verse': '«أَنَا الْكَرْمَةُ وَأَنْتُمُ الأَغْصَانُ. الَّذِي يَثْبُتُ فِيَّ وَأَنَا فِيهِ هذَا يَأْتِي بِثَمَرٍ كَثِيرٍ.» (يوحنا 15: 5)',
        'reflection': 'كيف تعيش الاتحاد الحقيقي بالمسيح يوميًا؟',
      },
      {
        'title': 'نقاوة القلب',
        'topic': 'النقاوة',
        'action': 'افحص قلبك واعترف بأي خطية خفية في صلاتك.',
        'verse': '«طُوبَى لِلأَنْقِيَاءِ الْقَلْبِ، لأَنَّهُمْ يُعَايِنُونَ اللَّهَ.» (متى 5: 8)',
        'reflection': 'هل هناك شيء في قلبك يحتاج تطهيرًا؟',
      },
      {
        'title': 'الأمانة في القليل',
        'topic': 'الأمانة',
        'action': 'كن أمينًا في مهمة صغيرة أو عهد صغير اليوم.',
        'verse': '«الأَمِينُ فِي الْقَلِيلِ أَمِينٌ أَيْضًا فِي الْكَثِيرِ.» (لوقا 16: 10)',
        'reflection': 'كيف تكافئك الأمانة في الصغير؟',
      },
      {
        'title': 'الرجوع عن الضلال',
        'topic': 'التوبة',
        'action': 'حدد عادة سيئة واحدة وابدأ في تركها اليوم.',
        'verse': '«ارْجِعُوا إِلَيَّ، يَقُولُ رَبُّ الْجُنُودِ، فَأَرْجِعَ إِلَيْكُمْ.» (زكريا 1: 3)',
        'reflection': 'ما الذي يبعدك عن الله وتريد الرجوع عنه؟',
      },
      {
        'title': 'القيادة الروحية',
        'topic': 'القيادة',
        'action': 'شجع شخصًا أصغر منك في الإيمان اليوم.',
        'verse': '«كُنْ قُدْوَةً لِلْمُؤْمِنِينَ فِي الْكَلاَمِ، فِي التَّصَرُّفِ، فِي الْمَحَبَّةِ.» (1 تيموثاوس 4: 12)',
        'reflection': 'من هو الشخص الذي تقوده روحيًا؟',
      },
      {
        'title': 'قوة الكلمة',
        'topic': 'الكلمة',
        'action': 'احفظ آية اليوم عن ظهر قلب ورددها.',
        'verse': '«سِرَاجٌ لِرِجْلِي كَلاَمُكَ وَنُورٌ لِسَبِيلِي.» (مزمور 119: 105)',
        'reflection': 'كيف أنارت الكلمة طريقك في الظلمة؟',
      },
      {
        'title': 'الشركة الروحية',
        'topic': 'الشركة',
        'action': 'تواصل مع أخ/أخت في الإيمان وشاركه تأمل اليوم.',
        'verse': '«لأَنَّهُ حَيْثُمَا اجْتَمَعَ اثْنَانِ أَوْ ثَلاَثَةٌ بِاسْمِي فَهُنَاكَ أَكُونُ فِي وَسَطِهِمْ.» (متى 18: 20)',
        'reflection': 'لماذا نحتاج الشركة الروحية في مسيرتنا؟',
      },
      {
        'title': 'الاستعداد للأبدية',
        'topic': 'الأبدية',
        'action': 'تأمل في الحياة الأبدية واكتب ما تعنيه لك.',
        'verse': '«أَنَا هُوَ الْقِيَامَةُ وَالْحَيَاةُ. مَنْ آمَنَ بِي وَلَوْ مَاتَ فَسَيَحْيَا.» (يوحنا 11: 25)',
        'reflection': 'كيف تستعد للحياة الأبدية كل يوم؟',
      },
      {
        'title': 'الالتزام والثبات',
        'topic': 'الثبات',
        'action': 'لخص رحلتك في الـ30 يومًا واكتب التزامك المستقبلي.',
        'verse': '«ثَابِتِينَ غَيْرَ مُتَزَعْزِعِينَ، مُكْثِرِينَ فِي عَمَلِ الرَّبِّ كُلَّ حِينٍ.» (1 كورنثوس 15: 58)',
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
