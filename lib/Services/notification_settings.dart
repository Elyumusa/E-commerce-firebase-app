import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsSettings {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'Eligere', // id
    'Eligere Channel', // title
    'This is The Eligere Notifications Channel.', // description
    importance: Importance.high,
  );
  static initialize() {
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    var initializingAndroidSetting =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings = InitializationSettings(
        android: initializingAndroidSetting, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static display(RemoteNotification notification) async {
    try {
      await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: 'launch_background',
            ),
          ));
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
