// ─── services/gift_service.dart ────────────────────────────────────────
// Daily Companion (رفيق يومي) — Divine Gift service (Local Storage)
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/daily_gift.dart';

class GiftService {
  static const String _giftsKey = 'daily_gifts_local';
  static const String _readsKey = 'user_reads_local';

  Future<List<DailyGift>> _fetchAllGifts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_giftsKey);
    if (jsonStr == null || jsonStr.isEmpty) return [];

    try {
      final List<dynamic> rawList = jsonDecode(jsonStr);
      return rawList
          .map((item) => DailyGift.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveGifts(List<DailyGift> gifts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(gifts.map((g) => g.toJson()).toList());
    await prefs.setString(_giftsKey, jsonStr);
  }

  /// Fetch the gift of the day by date
  Future<DailyGift?> fetchGiftForDate(String date) async {
    final gifts = await _fetchAllGifts();
    try {
      return gifts.firstWhere((g) => g.date == date);
    } catch (_) {
      // Generate default gift for date if none exists locally
      final defaultGift = _generateDefaultGift(date);
      gifts.add(defaultGift);
      await _saveGifts(gifts);
      return defaultGift;
    }
  }

  /// Fetch today's gift
  Future<DailyGift?> fetchTodayGift() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return fetchGiftForDate(today);
  }

  /// Mark a gift as read by a specific user
  Future<void> markGiftAsRead(String userId, String giftId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final readId = '${userId}_$today';
    final prefs = await SharedPreferences.getInstance();
    final List<String> reads = prefs.getStringList(_readsKey) ?? [];
    if (!reads.contains(readId)) {
      reads.add(readId);
      await prefs.setStringList(_readsKey, reads);
    }
  }

  /// Check if a user has read today's gift
  Future<bool> hasReadTodayGift(String userId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final readId = '${userId}_$today';
    final prefs = await SharedPreferences.getInstance();
    final List<String> reads = prefs.getStringList(_readsKey) ?? [];
    return reads.contains(readId);
  }

  /// Stream today's gift
  Stream<DailyGift?> watchTodayGift() async* {
    yield await fetchTodayGift();
  }

  /// Seed a gift — admin/seed function
  Future<void> createGift({
    required String date,
    required String verseReference,
    required String verseText,
    required String reflection,
    required String blessingReminder,
    String category = 'guidance',
  }) async {
    final gifts = await _fetchAllGifts();
    final gift = DailyGift(
      id: const Uuid().v4(),
      date: date,
      verseReference: verseReference,
      verseText: verseText,
      reflection: reflection,
      blessingReminder: blessingReminder,
      category: category,
    );
    gifts.removeWhere((g) => g.date == date);
    gifts.add(gift);
    await _saveGifts(gifts);
  }

  /// Built-in 30-day gift collection generator
  DailyGift _generateDefaultGift(String date) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(date);
    } catch (_) {
      parsedDate = DateTime.now();
    }

    final index = (parsedDate.day - 1) % _thirtyGifts.length;
    final template = _thirtyGifts[index];

    return DailyGift(
      id: 'gift_${date}_$index',
      date: date,
      verseReference: template.verseReference,
      verseText: template.verseText,
      reflection: template.reflection,
      blessingReminder: template.blessingReminder,
      category: template.category,
    );
  }

  /// 30 Curated Spiritual Gifts for the entire month (Smith & Van Dyke Full Text)
  static final List<DailyGift> _thirtyGifts = [
    const DailyGift(
      id: 'g1',
      date: '',
      verseReference: 'أمثال 23: 26',
      verseText: 'يَا ابْنِي أَعْطِنِي قَلْبَكَ، وَلْتُلاَحِظْ عَيْنَاكَ طُرُقِي.',
      reflection: 'الله لا يطلب منا سوى قلبنا المخلص ليملأه بمحبته وسلامه، وحين تلاحظ عيناك طرقه تجد النور والأمان.',
      blessingReminder: 'أعظم حاجة نقدمها لربنا هي قلبنا.. حاول دائماً تخلي قلبك ذبيحة حية مرضية لربنا 🤍🕊️',
      category: 'heart',
    ),
    const DailyGift(
      id: 'g2',
      date: '',
      verseReference: 'يوحنا 14: 27',
      verseText: 'سَلاَمًا أَتْرُكُ لَكُمْ. سَلاَمِي أُعْطِيكُمْ. لَيْسَ كَمَا يُعْطِي الْعَالَمُ أُعْطِيكُمْ أَنَا. لاَ تَضْطَرِبْ قُلُوبُكُمْ وَلاَ تَرُعْ.',
      reflection: 'سلام المسيح ينبع من حضوره الدائم في قلبك، يمنحك طمأنينة لا تعتمد على ظروف العالم المتغيرة.',
      blessingReminder: 'تذكر اليوم أنك محاط بسلام الله الذي يفوق كل عقل ويحفظ قلبك وفكرك 🕊️',
      category: 'peace',
    ),
    const DailyGift(
      id: 'g3',
      date: '',
      verseReference: 'إشعياء 41: 10',
      verseText: 'لاَ تَخَفْ لأَنِّي مَعَكَ. لاَ تَتَلَفَّتْ لأَنِّي إِلهُكَ. قَدْ قَوَّيْتُكَ وَأَعَنْتُكَ وَعَضَدْتُكَ بِيَمِينِ بِرِّي.',
      reflection: 'وعد إلهي ثابت في لحظات الضعف أو الحيرة: الرب يمسك بيمينك ويمنحك قوة تتجاوز طاقتك البشرية.',
      blessingReminder: 'مهما كانت التحديات أمامك، ثق أن إلهك معك يقويك ويعينك في كل خطوة 💪❤️',
      category: 'courage',
    ),
    const DailyGift(
      id: 'g4',
      date: '',
      verseReference: 'مزمور 23: 1',
      verseText: 'اَلرَّبُّ رَاعِيَّ فَلاَ يُعْوِزُنِي شَيْءٌ.',
      reflection: 'عندما يكون الرب هو راعيك الصالح، فلن ينقصك شيء من الخير والنعمة والسلام.',
      blessingReminder: 'نم واصحَ وأنت مطمئن: راعيك يسهر عليك ولا يدعك تحتاج لشيء 🌿',
      category: 'trust',
    ),
    const DailyGift(
      id: 'g5',
      date: '',
      verseReference: 'متى 11: 28',
      verseText: 'تَعَالَوْا إِلَيَّ يَا جَمِيعَ الْمُتْعَبِينَ وَالثَّقِيلِي الأَحْمَالِ، وَأَنَا أُرِيحُكُمْ.',
      reflection: 'دعوة مفتوحة من فادينا العطوف: ضع أحمالك وهمومك عند قدميه واسترح في محبته.',
      blessingReminder: 'ألقِ كل ثقل تحمله اليوم في حضن المسيح واستقبل راحته العجيبة 🤍',
      category: 'rest',
    ),
    const DailyGift(
      id: 'g6',
      date: '',
      verseReference: 'إرميا 29: 11',
      verseText: 'لأَنِّي عَرَفْتُ الأَفْكارَ الَّتِي أَنَا مُفَكِّرٌ بِهَا عَنْكُمْ، يَقُولُ الرَّبُّ، أَفْكَارَ سَلاَمٍ لاَ شَرٍّ، لأُعْطِيَكُمْ آخِرَةً وَرَجَاءً.',
      reflection: 'تدبير الله لحياتك دائمًا مملوء بالرجاء والخير، حتى وإن لم تفهم كل التفاصيل الآن.',
      blessingReminder: 'اطمئن لمستقبلك: مستقبل كتبه الله بمحبته وحكمته الفائقة 🌅',
      category: 'hope',
    ),
    const DailyGift(
      id: 'g7',
      date: '',
      verseReference: 'فيلبي 4: 13',
      verseText: 'أَسْتَطِيعُ كُلَّ شَيْءٍ فِي الْمَسِيحِ الَّذِي يُقَوِّينِي.',
      reflection: 'مصدر قوتك ليس في إمكانياتك الذاتية بل في نعمة المسيح الساكنة فيك.',
      blessingReminder: 'أنت قادر على تجاوز أي تجربة لأن قوة المسيح تعمل فيك ✨',
      category: 'strength',
    ),
    const DailyGift(
      id: 'g8',
      date: '',
      verseReference: 'مزمور 46: 1',
      verseText: 'اَللَّهُ لَنَا مَلْجَأٌ وَقُوَّةٌ، عَوْنًا فِي الضِّيْقَاتِ وُجِدَ شَدِيدًا.',
      reflection: 'حينما تحيط بك العواصف، يبقى الله هو الحصن المنيع الذي تلجأ إليه فتأمن.',
      blessingReminder: 'احتمِ بالله اليوم فهو ملجؤك الحريص وعونك الشديد وقت الحاجة 🛡️',
      category: 'refuge',
    ),
    const DailyGift(
      id: 'g9',
      date: '',
      verseReference: 'يوحنا 3: 16',
      verseText: 'لأَنَّهُ هكَذَا أَحَبَّ اللَّهُ الْعَالَمَ حَتَّى بَذَلَ ابْنَهُ الْوَحِيدَ، لِكَيْ لاَ يَهْلِكَ كُلُّ مَنْ يُؤْمِنُ بِهِ، بَلْ تَكُونُ لَهُ الْحَيَاةُ الأَبَدِيَّةُ.',
      reflection: 'محبة الله لك ليست مجرد كلمات بل بذل وفداء كامل أعطاك فيه الحياة الأبدية.',
      blessingReminder: 'تأمل اليوم في كمّ المحبة العظيمة التي أحبك بها الله على الصليب ✝️❤️',
      category: 'love',
    ),
    const DailyGift(
      id: 'g10',
      date: '',
      verseReference: 'أمثال 3: 5',
      verseText: 'تَوَكَّلْ عَلَى الرَّبِّ بِكُلِّ قَلْبِكَ، وَعَلَى فَهْمِكَ لاَ تَعْتَمِدْ.',
      reflection: 'التسليم الإيماني هو أن تضع ثقتك الكاملة في الله وتدع قيادة حياتك ليده الصالحة.',
      blessingReminder: 'سلم قراراتك وخططك للرب اليوم ودعه يمهد لك السبل 🛤️',
      category: 'faith',
    ),
    const DailyGift(
      id: 'g11',
      date: '',
      verseReference: 'مزمور 119: 105',
      verseText: 'سِرَاجٌ لِرِجْلِي كَلاَمُكَ وَنُورٌ لِسَبِيلِي.',
      reflection: 'كلمة الله هي البوصلة والنور الذي ينير طريقك وينقذك من ظلام الحيرة والتخبط.',
      blessingReminder: 'اجعل كلمة ربنا نوراً يوجه خطواتك وقراراتك في هذا اليوم 📖💡',
      category: 'word',
    ),
    const DailyGift(
      id: 'g12',
      date: '',
      verseReference: 'رومية 8: 28',
      verseText: 'وَنَحْنُ نَعْلَمُ أَنَّ كُلَّ الأُمُورِ تَعْمَلُ مَعًا لِلْخَيْرِ لِلَّذِينَ يُحِبُّونَ اللَّهَ، الَّذِينَ هُمْ مَدْعُوُّونَ حَسَبَ قَصْدِهِ.',
      reflection: 'حتى الأحداث التي تبدو صعبة أو غير مفهومة، يحولها الله بنعمته لبنيانك وخيرك الروحي.',
      blessingReminder: 'ثق أن الله ينسج كل أحداث يومك للخير والبركة 🌈',
      category: 'goodness',
    ),
    const DailyGift(
      id: 'g13',
      date: '',
      verseReference: 'مزمور 27: 1',
      verseText: 'الرَّبُّ نُورِي وَخَلاَصِي، مِمَّنْ أَخَافُ؟ الرَّبُّ حِصْنُ حَيَاتِي، مِمَّنْ أَرْتَعِبُ؟',
      reflection: 'حين يكون الرب هو حصن حياتك ونورك، تتبدد كل مخاوفك وتملأ شجاعة الإيمان قلبك.',
      blessingReminder: 'لا تخشَ أحداً أو شيئاً، فالرب حصنك ونورك الدايم 🏰✨',
      category: 'light',
    ),
    const DailyGift(
      id: 'g14',
      date: '',
      verseReference: '2 كورنثوس 12: 9',
      verseText: 'فَقَالَ لِي: «تَكْفِيكَ نِعْمَتِي، لأَنَّ قُوَّتِي فِي الضَّعْفِ تُكْمَلُ». فَبِبَالِغِ السُّرُورِ أَفْتَخِرُ بِالأَحْرَى فِي ضَعَفَاتِي، لِكَيْ تَحِلَّ عَلَيَّ قُوَّةُ الْمَسِيحِ.',
      reflection: 'في لحظات شعورك بالضعف، تظهر نعمة الله جلياً لتكمل نقصك وتمنحك نصراً روحيًا.',
      blessingReminder: 'نعمة المسيح كافية جداً لك اليوم في كل موقف وتحدٍّ 🌸',
      category: 'grace',
    ),
    const DailyGift(
      id: 'g15',
      date: '',
      verseReference: 'مزمور 34: 8',
      verseText: 'ذُوقُوا وَانْظُرُوا مَا أَطْيَبَ الرَّبَّ! طُوبَى لِلرَّجُلِ الْمُتَوَكِّلِ عَلَيْهِ.',
      reflection: 'العشرة الشخصية مع الله تذيق النفس طيبته وحلاوة حضوره وسعادته الأبديّة.',
      blessingReminder: 'تذوق صلاح الله في صلاتك اليوم واشعر بعذوبة عشرته 🍯❤️',
      category: 'goodness',
    ),
    const DailyGift(
      id: 'g16',
      date: '',
      verseReference: 'إشعياء 40: 31',
      verseText: 'وَأَمَّا مُنْتَظِرُو الرَّبِّ فَيُجَدِّدُونَ قُوَّةً. يَرْفَعُونَ أَجْنِحَةً كَالنُّسُورِ. يَرْكُضُونَ وَلاَ يَتْعَبُونَ، يَمْشُونَ وَلاَ يُعْيُونَ.',
      reflection: 'الانتظار على الرب بالصلاة يعيد تجديد حماسك وقوتك الروحية لترتفع فوق الهموم.',
      blessingReminder: 'انتظر الرب بالصلاة اليوم ليجدد طاقتك وترتفع بنعمته كالنسور 🦅',
      category: 'renewal',
    ),
    const DailyGift(
      id: 'g17',
      date: '',
      verseReference: 'يعقوب 1: 17',
      verseText: 'كُلُّ عَطِيَّةٍ صَالِحَةٍ وَكُلُّ مَوْهِبَةٍ تَامَّةٍ هِيَ مِنْ فَوْقُ، نَازِلَةٌ مِنْ عِنْدِ أَبِي الأَنْوَارِ، الَّذِي لَيْسَ عِنْدَهُ تَغْيِيرٌ وَلاَ ظِلُّ دَوَرَانٍ.',
      reflection: 'كل البركات والخيرات في حياتك هي عطايا شخصية من أب السماويات المحب.',
      blessingReminder: 'اشكر أبيك السماوي على عطاياه وبركاته غير المعدودة اليوم 🎁',
      category: 'blessing',
    ),
    const DailyGift(
      id: 'g18',
      date: '',
      verseReference: 'مزمور 103: 1',
      verseText: 'بَارِكِي يَا نَفْسِي الرَّبَّ، وَكُلُّ مَا فِي دَاخِلِي لِيُبَارِكِ اسْمَهُ الْقُدُّوسَ.',
      reflection: 'التسبيح والشكر يفتحان أبواب الفرح ويجعلان قلبك يفيض بذكر أحسان الرب.',
      blessingReminder: 'اجعل لسانك وقلبك يسبحان الرب ويشكرانه على كل حال 🎶🙌',
      category: 'praise',
    ),
    const DailyGift(
      id: 'g19',
      date: '',
      verseReference: 'يوحنا 8: 12',
      verseText: 'ثُمَّ كَلَّمَهُمْ يَسُوعُ أَيْضًا قَائِلاً: «أَنَا هُوَ نُورُ الْعَالَمِ. مَنْ يَتْبَعْنِي فَلاَ يَمْشِي فِي الظُّلْمَةِ بَلْ يَكُونُ لَهُ نُورُ الْحَيَاةِ».',
      reflection: 'سلوكك مع المسيح يضمن لك السير في نور الحق والحكمة وتجنب ظلمات الخطية.',
      blessingReminder: 'اتبع نور المسيح اليوم لتستنير طريقك وأفكارك وقراراتك ☀️',
      category: 'light',
    ),
    const DailyGift(
      id: 'g20',
      date: '',
      verseReference: 'أفسس 2: 8',
      verseText: 'لأَنَّكُمْ بِالنِّعْمَةِ مُخَلَّصُونَ، بِالإِيمَانِ، وَذلِكَ لَيْسَ مِنْكُمْ. هُوَ عَطِيَّةُ اللَّهِ.',
      reflection: 'خلاصك ومكانتك كابن لله هما عطية مجانية بالنعمة، وليسا باستحقاقك الذاتي.',
      blessingReminder: 'افرح بنعمة الله المجانية المحيطة بك وعش بكرامة أبناء الملك 👑',
      category: 'grace',
    ),
    const DailyGift(
      id: 'g21',
      date: '',
      verseReference: 'مزمور 121: 1-2',
      verseText: 'أَرْفَعُ عَيْنَيَّ إِلَى الْجِبَالِ، مِنْ حَيْثُ يَأْتِي عَوْنِي. عَوْنِي مِنْ عِنْدِ الرَّبِّ، صَانِعِ السَّمَاوَاتِ وَالأَرْضِ.',
      reflection: 'لا تركز على تضاريس المشاكل، بل ارفع عينيك للخالق العظيم الذي يحفظك ويعينك.',
      blessingReminder: 'ارفع عينيك للرب اليوم بثقة، فمعونته حاضرة وصانع الكون معك 🏔️',
      category: 'help',
    ),
    const DailyGift(
      id: 'g22',
      date: '',
      verseReference: 'صفنيا 3: 17',
      verseText: 'الرَّبُّ إِلهُكِ فِي وَسَطِكِ جَبَّارٌ. يُخَلِّصُ. يَبْتَهِجُ بِكِ فَرَحًا. يَسْكُنُ فِي مَحَبَّتِهِ. يَبْتَهِجُ بِكِ بِتَرْنِيمٍ.',
      reflection: 'الله يفرح بك ويبتهج بوجودك ويبسط محبته عليك كوالد حنون وفادٍ جبار.',
      blessingReminder: 'تذكر أن الله يفرح بك ويبتهج بمحبتك اليوم 💖',
      category: 'joy',
    ),
    const DailyGift(
      id: 'g23',
      date: '',
      verseReference: 'متى 6: 34',
      verseText: 'فَلاَ تَهْتَمُّوا لِلْغَدِ، لأَنَّ الْغَدَ يَهْتَمُّ بِمَا لِنَفْسِهِ. يَكْفِي الْيَوْمَ شَرُّهُ.',
      reflection: 'ترك القلق بشأن الغد يعينك على عيش نعمة اليوم وشكر الله على لحظتك الحاضرة.',
      blessingReminder: 'عش يومك هذا في سلام واترك غدك في يد مدبر الكون 🌅',
      category: 'peace',
    ),
    const DailyGift(
      id: 'g24',
      date: '',
      verseReference: 'مزمور 55: 22',
      verseText: 'أَلْقِ عَلَى الرَّبِّ هَمَّكَ فَهُوَ يَعُولُكَ. لاَ يَدَعُ الصِّدِّيقَ يَتَزَعْزَعُ أَبَدًا.',
      reflection: 'ربنا مستعد يحمل كل أثقالك وهمومك، ويمنحك ثباتاً واستقراراً نفسياً وروحيًا.',
      blessingReminder: 'ألقِ أثقالك على الرب اليوم واطمئن؛ فهو يعولك ولا يدعك تتزعزع ⚓',
      category: 'care',
    ),
    const DailyGift(
      id: 'g25',
      date: '',
      verseReference: '1 بطرس 5: 7',
      verseText: 'مُلْقِينَ كُلَّ هَمِّكُمْ عَلَيْهِ، لأَنَّهُ هُوَ يَعْتَنِي بِكُمْ.',
      reflection: 'الله يهتم بأصقاع تفاصيل حياتك واحتياجاتك اليومية لأنه يحبك محبة شخصية.',
      blessingReminder: 'اطمئن.. الله يعتني بك وبكل أمورك بعناية إلهية فادية 🕊️',
      category: 'care',
    ),
    const DailyGift(
      id: 'g26',
      date: '',
      verseReference: 'إشعياء 43: 1',
      verseText: 'وَالآنَ هكَذَا يَقُولُ الرَّبُّ، خَالِقُكَ يَا يَعْقُوبُ وَبَارِئُكَ يَا إِسْرَائِيلُ: «لاَ تَخَفْ لأَنِّي فَدَيْتُكَ. دَعَوْتُكَ بِاسْمِكَ. أَنْتَ لِي».',
      reflection: 'أنت لست مجرد غريب في العالم، بل ابناً مفدياً يعرفه الله باسمه ويخصه بمحبته.',
      blessingReminder: 'افتخر بانتسابك لله اليوم: أنت ابن غالي ومفدى بدمه ✝️',
      category: 'identity',
    ),
    const DailyGift(
      id: 'g27',
      date: '',
      verseReference: 'مزمور 37: 4',
      verseText: 'وَتَلَذَّذْ بِالرَّبِّ فَيُعْطِيَكَ سُؤْلَ قَلْبِكَ.',
      reflection: 'حينما تضع لذتك وسعادتك في الله وفي محبته، ينسجم قلبك مع مشيئته وينعم بإجابات صلواتك.',
      blessingReminder: 'اجعل محبة ربنا هي لذتك الأولى اليوم وسوف يملأ قلبك بالفرح 💖',
      category: 'joy',
    ),
    const DailyGift(
      id: 'g28',
      date: '',
      verseReference: 'يوحنا 15: 5',
      verseText: 'أَنَا الْكَرْمَةُ وَأَنْتُمُ الأَغْصَانُ. الَّذِي يَثْبُتُ فِيَّ وَأَنَا فِيهِ هذَا يَأْتِي بِثَمَرٍ كَثِيرٍ، لأَنَّكُمْ بِدُونِي لاَ تَقْدِرُونَ أَنْ تَفْعَلُوا شَيْئًا.',
      reflection: 'الثبات في المسيح عبر الصلاة والكلمة هو السر الذي يجعلك تثمر ثمار الروح القدس.',
      blessingReminder: 'اثبت في المسيح اليوم بالصلاة والكلمة ليكون يومك مثمراً ومباركاً 🍇',
      category: 'abiding',
    ),
    const DailyGift(
      id: 'g29',
      date: '',
      verseReference: 'رومية 12: 2',
      verseText: 'وَلاَ تُشَاكِلُوا هذَا الدَّهْرَ، بَلِ تَغَيَّرُوا عَنْ تَجْدِيدِ أَذْهَانِكُمْ، لِتَخْتَبِرُوا مَا هِيَ إِرَادَةُ اللَّهِ: الصَّالِحَةُ الْمَرْضِيَّةُ الْكَامِلَةُ.',
      reflection: 'تجديد فكرك بكلمة الله يحررك من أفكار العالم السلبية ويفتح عينيك لمشيئة الله الصالحة.',
      blessingReminder: 'جدد أفكارك بنور كلمة ربنا اليوم واختبر حلاوة مشيئته 🧠✨',
      category: 'mind',
    ),
    const DailyGift(
      id: 'g30',
      date: '',
      verseReference: 'يوحنا 16: 33',
      verseText: 'قَدْ كَلَّمْتُكُمْ بِهذَا لِيَكُونَ لَكُمْ فِيَّ سَلاَمٌ. فِي الْعَالَمِ سَيَكُونُ لَكُمْ ضِيقٌ، وَلكِنْ ثِقُوا: أَنَا قَدْ غَلَبْتُ الْعَالَمَ.',
      reflection: 'وعد النصرة من فادينا العظيم: مهما كانت ضغوط العالم، فالمسيح غالب ومصدر سلامك الدائم.',
      blessingReminder: 'ثق وافرح: فاديك قد غلب العالم وهو معك حتى الانقضاء 🏆✝️',
      category: 'victory',
    ),
  ];
}

