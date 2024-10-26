import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ChuckerNotification {
  static final ChuckerNotification _singleton = ChuckerNotification._internal();

  factory ChuckerNotification() => _singleton;

  ChuckerNotification._internal();

  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification() async {
    ChuckerFlutter.showNotification = false;

    // Configure local notification for Android
    const android = AndroidNotificationDetails(
      'chucker_channel_id',
      'Chucker Notifications',
      ongoing: true,
      autoCancel: false,
      importance: Importance.low,
      playSound: false,
    );

    // Configure local notification for iOS
    const ios = DarwinNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
      presentBanner: false,
    );

    const platformChannelSpecifics = NotificationDetails(
      android: android,
      iOS: ios,
    );

    final settings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: (
          _,
          __,
          ___,
          ____,
        ) => ChuckerFlutter.showChuckerScreen(),
      ),
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (_) =>
          ChuckerFlutter.showChuckerScreen(),
    );

    // Show local notification
    await _notificationsPlugin.show(
      0,
      "Chucker Notifications",
      "",
      platformChannelSpecifics,
    );
  }
}
