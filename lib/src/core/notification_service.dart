import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const int MORNING_NOTIFICATION_ID = 1;
  static const int NOON_NOTIFICATION_ID = 2;
  static const int AFTERNOON_NOTIFICATION_ID = 3;
  static const int SUNSET_NOTIFICATION_ID = 4;
  static const int NIGHT_NOTIFICATION_ID = 5;

  static const int MORNING_ALARM_ID = 6;
  static const int NOON_ALARM_ID = 7;
  static const int AFTERNOON_ALARM_ID = 8;
  static const int SUNSET_ALARM_ID = 9;
  static const int NIGHT_ALARM_ID = 10;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(_, __, ___, ____) {
    return Future.delayed(Duration(milliseconds: 1));
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }
}
