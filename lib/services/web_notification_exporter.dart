// ─── services/web_notification_exporter.dart ─────────────────────────────
// Conditional export for Web vs Mobile notification helpers
export 'web_notification_stub.dart'
    if (dart.library.html) 'web_notification_helper.dart';
