import 'package:bloc/bloc.dart';
import 'package:prayer_times_flutter/src/core/notification_service.dart';
import 'package:prayer_times_flutter/src/core/preferences_manager.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_event.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  SharedPreferences? sp;

  SettingBloc() : super(SettingInitialState()) {
    Future.delayed(Duration.zero, () async {
      this.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      this.sp = await SharedPreferences.getInstance();
    });
  }

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is ToggleAlarm) {
      yield* _toggleAlarm(event);
    } else if (event is ToggleNotification) {
      yield* _toggleNotification(event);
    }
  }

  Stream<SettingState> _toggleAlarm(ToggleAlarm event) async* {
    switch (event.horizonType) {
      case HorizonType.Morning:
        _toggleSP(PreferencesManager.MORNING_ALARM);
        break;
      case HorizonType.Noon:
        _toggleSP(PreferencesManager.NOON_ALARM);
        break;
      case HorizonType.Afternoon:
        _toggleSP(PreferencesManager.AFTERNOON_ALARM);
        break;
      case HorizonType.Sunset:
        _toggleSP(PreferencesManager.SUNSET_ALARM);
        break;
      case HorizonType.Night:
        _toggleSP(PreferencesManager.NIGHT_ALARM);
        break;
    }

    yield AlarmToggled();
  }

  Stream<SettingState> _toggleNotification(ToggleNotification event) async* {
    switch (event.horizonType) {
      case HorizonType.Morning:
        _toggleSP(PreferencesManager.MORNING_NOTIFICATION);
        // _scheduleNotification(NotificationService.MORNING_NOTIFICATION_ID, message, event.actionType);
        break;
      case HorizonType.Noon:
        _toggleSP(PreferencesManager.NOON_NOTIFICATION);
        break;
      case HorizonType.Afternoon:
        _toggleSP(PreferencesManager.AFTERNOON_NOTIFICATION);
        break;
      case HorizonType.Sunset:
        _toggleSP(PreferencesManager.SUNSET_NOTIFICATION);
        break;
      case HorizonType.Night:
        _toggleSP(PreferencesManager.NIGHT_NOTIFICATION);
        break;
    }

  yield NotificationToggled();
  }

  void _toggleSP(String key) async {
    if (sp?.getBool(key) ?? false) {
      await sp?.setBool(key, false);
    } else {
      await sp?.setBool(key, true);
    }
  }

  void _scheduleNotification(
      int id, String message, ActionType actionType) async {
        int hour = 0;
        int minute = 0;
        switch(id) {
          case NotificationService.MORNING_NOTIFICATION_ID:          
          break;
          case NotificationService.NOON_NOTIFICATION_ID:
          break;
          case NotificationService.AFTERNOON_NOTIFICATION_ID:
          break;
          case NotificationService.SUNSET_NOTIFICATION_ID:
          break;
          case NotificationService.NIGHT_NOTIFICATION_ID:
          break;
        }

    await flutterLocalNotificationsPlugin!.zonedSchedule(
        id,
        'Its prayer time!',
        message,
        _getNotificationTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _getNotificationTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
