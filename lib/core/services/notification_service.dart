import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'backup_of_record';
  static const _channelName = 'Backup of Record';

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
  }

  Future<void> showError(String title, String body) => _show(
        id: 1,
        title: title,
        body: body,
        importance: Importance.high,
      );

  Future<void> showInfo(String title, String body) => _show(
        id: 2,
        title: title,
        body: body,
        importance: Importance.defaultImportance,
      );

  Future<void> _show({
    required int id,
    required String title,
    required String body,
    required Importance importance,
  }) =>
      _plugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            importance: importance,
            priority: Priority.defaultPriority,
          ),
        ),
      );
}
