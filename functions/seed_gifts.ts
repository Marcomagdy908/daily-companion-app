// ─── functions/seed_gifts.ts ───────────────────────────────────────────
// Daily Companion (رفيق يومي) — Firebase Cloud Function: Seed Daily Gifts
//
// Deploy this function to auto-generate 365 days of daily gifts.
// Each gift has a verse, reflection, and blessing reminder in Arabic.
// ────────────────────────────────────────────────────────────────────────

import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

interface DailyGift {
  date: string;
  verseReference: string;
  verseText: string;
  reflection: string;
  blessingReminder: string;
  category: string;
  isRead: boolean;
}

// ─── Seed Data: 7-Day Starter Set (extend to 365 as needed) ────────────
const weeklyGifts: Omit<DailyGift, 'date' | 'isRead'>[] = [
  // Week 1: Foundation
  {
    verseReference: 'متى ٦:٣٣',
    verseText: 'اَلْتَمِسُوا أَوَّلاً مَلَكُوتَ ٱللَّهِ وَبِرَّهُ وَهَذِهِ كُلُّهَا تُزَادُ لَكُمْ.',
    reflection: 'عندما تضع الله في المركز الأول، كل ما تحتاجه يأتي في وقته المثالي. لا تقلق بشأن الغد، بل ثق في تدبيره.',
    blessingReminder: 'الله يمنحك سلامًا يفوق كل عقل اليوم.',
    category: 'guidance',
  },
  {
    verseReference: 'إشعياء ٤١:١٠',
    verseText: 'لَا تَخَفْ لِأَنِّي مَعَكَ. لَا تَتَلَفَّتْ لِأَنِّي إِلَهُكَ. قَدْ أَيَّدْتُكَ وَأَعَنْتُكَ وَعَضَدْتُكَ بِيَمِينِ بِرِّي.',
    reflection: 'حتى في أصعب الظروف، الله معك. يده اليمنى تمسك بك ولن تتركك.',
    blessingReminder: 'الشجاعة والقوة يمنحك إياهما الرب اليوم.',
    category: 'strength',
  },
  {
    verseReference: 'مزمور ٢٣:١',
    verseText: 'اَلرَّبُّ رَاعِيَّ فَلَا يُعْوِزُنِي شَيْءٌ.',
    reflection: 'كراعٍ صالح، الله يهتم بكل تفاصيل حياتك. لا شيء ينقصك عندما يكون هو راعيك.',
    blessingReminder: 'الاكتفاء والراحة في رعاية الله لك.',
    category: 'peace',
  },
  {
    verseReference: 'إرميا ٢٩:١١',
    verseText: 'لِأَنِّي عَرَفْتُ ٱلْأَفْكَارَ ٱلَّتِي أَنَا مُفْتَكِرٌ بِهَا عَنْكُمْ، يَقُولُ ٱلرَّبُّ، أَفْكَارَ سَلَامٍ لَا شَرٍّ، لِأُعْطِيَكُمْ آخِرَةً وَرَجَاءً.',
    reflection: 'خطة الله لحياتك مليئة بالرجاء والمستقبل المشرق. ثق في توقيته.',
    blessingReminder: 'الله يعد لك مستقبلاً مليئًا بالرجاء.',
    category: 'hope',
  },
  {
    verseReference: 'فيلبي ٤:١٣',
    verseText: 'أَسْتَطِيعُ كُلَّ شَيْءٍ فِي ٱلْمَسِيحِ ٱلَّذِي يُقَوِّينِي.',
    reflection: 'لا يوجد تحدٍ أكبر من قوة المسيح التي تسكن فيك. به تقدر على كل شيء.',
    blessingReminder: 'قوة المسيح العاملة فيك تتجدد اليوم.',
    category: 'strength',
  },
  {
    verseReference: 'مزمور ٤٦:١',
    verseText: 'اَللهُ لَنَا مَلْجَأٌ وَقُوَّةٌ. عَوْنًا فِي ٱلضِّيقَاتِ شَدِيدَ ٱلْوُجُودِ.',
    reflection: 'في خضم العاصفة، الله هو ملجأك الآمن. اركض إليه قبل أي شيء آخر.',
    blessingReminder: 'الله ملجأك وحصنك المنيع اليوم.',
    category: 'protection',
  },
  {
    verseReference: '٢ كورنثوس ١٢:٩',
    verseText: 'تَكْفِيكَ نِعْمَتِي، لِأَنَّ قُوَّتِي فِي ٱلضَّعْفِ تُكْمَلُ.',
    reflection: 'في ضعفك تكمن أعظم قوة. عندما تعترف بضعفك، تظهر قوة الله.',
    blessingReminder: 'نعمة الله كافية لك في كل ضعف.',
    category: 'grace',
  },
];

// ─── Seed Function ─────────────────────────────────────────────────────
export const seedDailyGifts = async () => {
  const startDate = new Date();
  const batch = db.batch();
  const giftsRef = db.collection('daily_gifts');

  for (let i = 0; i < 365; i++) {
    const date = new Date(startDate);
    date.setDate(date.getDate() + i);
    const dateStr = date.toISOString().split('T')[0];

    // Cycle through the 7 weekly gifts
    const template = weeklyGifts[i % weeklyGifts.length];

    const docRef = giftsRef.doc();
    batch.set(docRef, {
      ...template,
      date: dateStr,
      isRead: false,
    });
  }

  await batch.commit();
  console.log('✅ Seeded 365 daily gifts!');
};

// ─── Run manually: firebase functions:shell → seedDailyGifts() ─────────
