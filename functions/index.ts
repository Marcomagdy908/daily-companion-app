// ─── functions/index.ts ────────────────────────────────────────────────
// Daily Companion (رفيق يومي) — Firebase Cloud Functions entry point
import * as admin from 'firebase-admin';

admin.initializeApp();

export { seedDailyGifts } from './seed_gifts';

// ─── Scheduled: Auto-check missed days (runs daily at midnight) ────────
export const checkMissedDays = async () => {
  const db = admin.firestore();
  const today = new Date().toISOString().split('T')[0];

  const usersSnapshot = await db.collection('users').get();

  for (const userDoc of usersSnapshot.docs) {
    const userId = userDoc.id;

    // Check if user made a commitment today
    const todayCommitment = await db
      .collection('commitments')
      .where('userId', '==', userId)
      .where('date', '==', today)
      .limit(1)
      .get();

    if (todayCommitment.empty) {
      // User missed today — handle growth pause
      const growthRef = db.collection('growth_states').doc(userId);
      const growthDoc = await growthRef.get();

      if (growthDoc.exists) {
        const data = growthDoc.data()!;
        const missedDates = data.missedDates || [];
        missedDates.push(today);

        await growthRef.update({
          currentStreak: 0,
          missedDates: missedDates,
          brightnessValue: Math.max(0, (data.brightnessValue || 0) - 0.01),
        });
      }
    }
  }

  console.log('✅ Checked missed days for all users');
};

// ─── Trigger: When a commitment is created, update growth ──────────────
export const onCommitmentCreated = async (
  snapshot: admin.firestore.DocumentSnapshot,
) => {
  const data = snapshot.data();
  if (!data) return;

  const db = admin.firestore();
  const growthRef = db.collection('growth_states').doc(data.userId);
  const growthDoc = await growthRef.get();

  if (!growthDoc.exists) {
    // Initialize growth state
    await growthRef.set({
      userId: data.userId,
      currentStreak: 1,
      longestStreak: 1,
      totalCommitmentsCompleted: 1,
      growthLevel: 2,
      leavesEarned: 1,
      activeTheme: 'tree',
      lastCompletedDate: data.date,
      missedDates: [],
      brightnessValue: 0.02,
    });
    return;
  }

  const growth = growthDoc.data()!;
  const newStreak = (growth.currentStreak || 0) + 1;
  const newLongestStreak = Math.max(newStreak, growth.longestStreak || 0);

  // Leaves bonus logic
  let leafBonus = 1;
  if (newStreak >= 30) leafBonus = 5;
  else if (newStreak >= 14) leafBonus = 3;
  else if (newStreak >= 7) leafBonus = 2;

  await growthRef.update({
    currentStreak: newStreak,
    longestStreak: newLongestStreak,
    totalCommitmentsCompleted: admin.firestore.FieldValue.increment(1),
    growthLevel: Math.min(100, (growth.growthLevel || 0) + 2),
    leavesEarned: (growth.leavesEarned || 0) + leafBonus,
    lastCompletedDate: data.date,
    brightnessValue: Math.min(1.0, (growth.brightnessValue || 0) + 0.02),
  });

  console.log(`🌱 Growth updated for user ${data.userId}: streak=${newStreak}`);
};
