// ─── services/web_notification_stub.dart ──────────────────────────────────
// Stub implementation for non-web platforms (Android / iOS)

void showWebNotification(String title, String body) {
  // No-op on mobile native platforms
}

Future<bool> requestWebNotificationPermission() async {
  return false;
}
