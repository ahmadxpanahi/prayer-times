import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:prayer_times_flutter/src/core/notification_service.dart';
import 'package:prayer_times_flutter/src/core/preferences_manager.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_event.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prayer_times_flutter/src/utils/time_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:prayer_times_flutter/src/utils/extensions.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  SharedPreferences? sp;

  final MethodChannel platform =
      MethodChannel('alpha.dev/flutter_local_notifications');

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
        _scheduleNotification(
          NotificationService.MORNING_ALARM_ID,
          'AZAN !!',
          "Morning prayer...",
          event.actionType,
          isAlarm: true,
        );
        break;
      case HorizonType.Noon:
        _toggleSP(PreferencesManager.NOON_ALARM);
        _scheduleNotification(
          NotificationService.NOON_ALARM_ID,
          'AZAN !!',
          "Noon prayer...",
          event.actionType,
          isAlarm: true,
        );
        break;
      case HorizonType.Afternoon:
        _toggleSP(PreferencesManager.AFTERNOON_ALARM);
        _scheduleNotification(
          NotificationService.AFTERNOON_ALARM_ID,
          'AZAN !!',
          "Afternoon prayer...",
          event.actionType,
          isAlarm: true,
        );
        break;
      case HorizonType.Sunset:
        _toggleSP(PreferencesManager.SUNSET_ALARM);
        _scheduleNotification(
          NotificationService.SUNSET_ALARM_ID,
          'AZAN !!',
          "Sunset prayer...",
          event.actionType,
          isAlarm: true,
        );
        break;
      case HorizonType.Night:
        _toggleSP(PreferencesManager.NIGHT_ALARM);
        _scheduleNotification(
          NotificationService.NIGHT_ALARM_ID,
          'AZAN !!',
          "Night prayer...",
          event.actionType,
          isAlarm: true,
        );
        break;
    }

    yield AlarmToggled();
  }

  Stream<SettingState> _toggleNotification(ToggleNotification event) async* {
    switch (event.horizonType) {
      case HorizonType.Morning:
        _toggleSP(PreferencesManager.MORNING_NOTIFICATION);
        _scheduleNotification(
          NotificationService.MORNING_NOTIFICATION_ID,
          'Its prayer time!',
          "Morning prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Noon:
        _toggleSP(PreferencesManager.NOON_NOTIFICATION);
        _scheduleNotification(
          NotificationService.NOON_NOTIFICATION_ID,
          'Its prayer time!',
          "Noon prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Afternoon:
        _toggleSP(PreferencesManager.AFTERNOON_NOTIFICATION);
        _scheduleNotification(
          NotificationService.AFTERNOON_NOTIFICATION_ID,
          'Its prayer time!',
          "Afternoon prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Sunset:
        _toggleSP(PreferencesManager.SUNSET_NOTIFICATION);
        _scheduleNotification(
          NotificationService.SUNSET_NOTIFICATION_ID,
          'Its prayer time!',
          "Sunset prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Night:
        _toggleSP(PreferencesManager.NIGHT_NOTIFICATION);
        _scheduleNotification(
          NotificationService.NIGHT_NOTIFICATION_ID,
          'Its prayer time!',
          "Night prayer time arrives in 5 minutes",
          event.actionType,
        );
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
      int id, String title, String message, ActionType actionType,
      {bool isAlarm = false}) async {
    String _alarmFile = 'sabah';
    String time = "00:00";
    switch (id) {
      case NotificationService.MORNING_NOTIFICATION_ID:
      case NotificationService.MORNING_ALARM_ID:
        _alarmFile = 'sabah';
        time = sp?.getString(PreferencesManager.MORNING_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.NOON_NOTIFICATION_ID:
      case NotificationService.NOON_ALARM_ID:
        _alarmFile = 'ogle';
        time = sp?.getString(PreferencesManager.NOON_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.AFTERNOON_NOTIFICATION_ID:
      case NotificationService.AFTERNOON_ALARM_ID:
        _alarmFile = 'ikindi';
        time =
            sp?.getString(PreferencesManager.AFTERNOON_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.SUNSET_NOTIFICATION_ID:
      case NotificationService.SUNSET_ALARM_ID:
        _alarmFile = 'aksam';
        time = sp?.getString(PreferencesManager.SUNSET_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.NIGHT_NOTIFICATION_ID:
      case NotificationService.NIGHT_ALARM_ID:
        _alarmFile = 'yatsi';
        time = sp?.getString(PreferencesManager.NIGHT_PRAYER_TIME) ?? '00:00';
        break;
    }

    if (time == '00:00') return;

    switch (actionType) {
      case ActionType.Enable:
        if (isAlarm) {
          await flutterLocalNotificationsPlugin?.zonedSchedule(
              id,
              title,
              message,
              _getNotificationTime(time, false),
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'muftuluk_daily_azan_alarm',
                  'Muftuluk daily azan alarm',
                  'Daily alarm for prayer times',
                  sound: RawResourceAndroidNotificationSound(_alarmFile),
                  playSound: true,
                  priority: Priority.high,
                ),
              ),
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              matchDateTimeComponents: DateTimeComponents.time);
        } else {
          final String? alarmUri =
              await platform.invokeMethod<String>('getAlarmUri');
          final UriAndroidNotificationSound defaultUserSound =
              UriAndroidNotificationSound(alarmUri!);

          await flutterLocalNotificationsPlugin?.zonedSchedule(
              id,
              title,
              message,
              _getNotificationTime(time, true),
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'muftuluk_daily_azan_notification',
                  'Muftuluk daily azan notification',
                  'Daily notification for prayer times',
                  sound: defaultUserSound,
                  playSound: true,
                  priority: Priority.high,
                ),
              ),
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              matchDateTimeComponents: DateTimeComponents.time);
        }
        break;
      case ActionType.Disable:
        await flutterLocalNotificationsPlugin?.cancel(id);        
        break;
    }
  }

  tz.TZDateTime _getNotificationTime(String time, bool addPreTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final int hour = TimeUtils.getHourFromTime(time);
    final int minute = TimeUtils.getMinuteFromTime(time);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute)
            .add(Duration(minutes: addPreTime ? -5 : 0));

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    return scheduledDate;
  }
}
