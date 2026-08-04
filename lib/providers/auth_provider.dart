// ─── providers/auth_provider.dart ───────────────────────────────────────
// Daily Companion (رفيق يومي) — Firebase Auth provider (abstracted)
//
// This file is referenced by daily_lock_provider.dart.
// Replace the placeholder authStateProvider with real Firebase Auth.
// ────────────────────────────────────────────────────────────────────────

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The actual Firebase Auth state stream
final firebaseAuthStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Convenience: currently signed-in user
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(firebaseAuthStateChangesProvider).valueOrNull;
});

/// Whether the user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});

/// Auth state for daily_lock_provider compatibility (alias)
final authStateProvider = firebaseAuthStateChangesProvider;
