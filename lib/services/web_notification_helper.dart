// ─── services/web_notification_helper.dart ────────────────────────────────
// Real HTML5 browser Notification API implementation for Web platform
import 'dart:html' as html;

void showWebNotification(String title, String body) {
  try {
    if (html.Notification.permission == 'granted') {
      html.Notification(
        title,
        body: body,
        icon: 'assets/images/app_logo.png',
      );
    } else if (html.Notification.permission != 'denied') {
      html.Notification.requestPermission().then((permission) {
        if (permission == 'granted') {
          html.Notification(
            title,
            body: body,
            icon: 'assets/images/app_logo.png',
          );
        }
      });
    }
  } catch (e) {
    // Fallback if browser environment restricts notifications
  }
}

Future<bool> requestWebNotificationPermission() async {
  try {
    final permission = await html.Notification.requestPermission();
    return permission == 'granted';
  } catch (_) {
    return false;
  }
}
