// ─── providers/auth_provider.dart ───────────────────────────────────────
// Daily Companion (رفيق يومي) — Local User Auth provider (No Firebase Auth)
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Representation of a local offline user
class LocalUser {
  final String uid;
  final String displayName;
  final String email;

  const LocalUser({
    this.uid = 'local_user',
    this.displayName = 'رفيق',
    this.email = 'local@companion.app',
  });
}

/// Stream of auth state changes (always yields local user)
final authStateProvider = StreamProvider<LocalUser?>((ref) {
  return Stream.value(const LocalUser());
});

/// Convenience: currently active local user
final currentUserProvider = Provider<LocalUser?>((ref) {
  return const LocalUser();
});

/// Always true for local offline app
final isAuthenticatedProvider = Provider<bool>((ref) {
  return true;
});

