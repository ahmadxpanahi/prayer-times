import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bloc/bloc.dart';
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
        _scheduleAlarm(
            NotificationService.MORNING_NOTIFICATION_ID, event.actionType);
        break;
      case HorizonType.Noon:
        _toggleSP(PreferencesManager.NOON_ALARM);
        _scheduleAlarm(
            NotificationService.NOON_NOTIFICATION_ID, event.actionType);
        break;
      case HorizonType.Afternoon:
        _toggleSP(PreferencesManager.AFTERNOON_ALARM);
        _scheduleAlarm(
            NotificationService.AFTERNOON_NOTIFICATION_ID, event.actionType);
        break;
      case HorizonType.Sunset:
        _toggleSP(PreferencesManager.SUNSET_ALARM);
        _scheduleAlarm(
            NotificationService.SUNSET_NOTIFICATION_ID, event.actionType);
        break;
      case HorizonType.Night:
        _toggleSP(PreferencesManager.NIGHT_ALARM);
        _scheduleAlarm(
            NotificationService.NIGHT_NOTIFICATION_ID, event.actionType);
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
          "Morning prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Noon:
        _toggleSP(PreferencesManager.NOON_NOTIFICATION);
        _scheduleNotification(
          NotificationService.NOON_NOTIFICATION_ID,
          "Noon prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Afternoon:
        _toggleSP(PreferencesManager.AFTERNOON_NOTIFICATION);
        _scheduleNotification(
          NotificationService.AFTERNOON_NOTIFICATION_ID,
          "Afternoon prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Sunset:
        _toggleSP(PreferencesManager.SUNSET_NOTIFICATION);
        _scheduleNotification(
          NotificationService.SUNSET_NOTIFICATION_ID,
          "Sunset prayer time arrives in 5 minutes",
          event.actionType,
        );
        break;
      case HorizonType.Night:
        _toggleSP(PreferencesManager.NIGHT_NOTIFICATION);
        _scheduleNotification(
          NotificationService.NIGHT_NOTIFICATION_ID,
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
      int id, String message, ActionType actionType) async {
    String time = "00:00";
    switch (id) {
      case NotificationService.MORNING_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.MORNING_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.NOON_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.NOON_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.AFTERNOON_NOTIFICATION_ID:
        time =
            sp?.getString(PreferencesManager.AFTERNOON_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.SUNSET_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.SUNSET_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.NIGHT_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.NIGHT_PRAYER_TIME) ?? '00:00';
        break;
    }

    if (time == '00:00') return;

    switch (actionType) {
      case ActionType.Enable:
        await flutterLocalNotificationsPlugin?.zonedSchedule(
            id,
            'Its prayer time!',
            message,
            _getNotificationTime(time),
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
        break;
      case ActionType.Disable:
        await flutterLocalNotificationsPlugin?.cancel(id);
        break;
    }
  }

  void _scheduleAlarm(int id, ActionType actionType) async {
    String time = "00:00";
    switch (id) {
      case NotificationService.MORNING_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.MORNING_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.NOON_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.NOON_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.AFTERNOON_NOTIFICATION_ID:
        time =
            sp?.getString(PreferencesManager.AFTERNOON_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.SUNSET_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.SUNSET_PRAYER_TIME) ?? '00:00';
        break;
      case NotificationService.NIGHT_NOTIFICATION_ID:
        time = sp?.getString(PreferencesManager.NIGHT_PRAYER_TIME) ?? '00:00';
        break;
    }

    if (time == '00:00') return;

    switch (actionType) {
      case ActionType.Enable:
        _setAlarm(time, id);
        break;
      case ActionType.Disable:
        _cancelAlarm(id);
        break;
    }
  }

  void _setAlarm(time, id) {
    DateTime now = DateTime.now();
    DateTime _prayerTime = DateTime.parse(
        '${now.year}-${now.month.timePadded}-${now.day.timePadded} $time');
    print(_prayerTime);
    print('DURATION: ${TimeUtils.dateTimeToDuration(_prayerTime)}');
    Future.delayed(Duration.zero, () async {
      await AndroidAlarmManager.periodic(
          TimeUtils.dateTimeToDuration(_prayerTime), id, playAlarm);
    });
  }

  void _cancelAlarm(id) {
    Future.delayed(Duration.zero, () async {
      await AndroidAlarmManager.cancel(id);
    });
  }

  tz.TZDateTime _getNotificationTime(String time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final int hour = TimeUtils.getHourFromTime(time);
    final int minute = TimeUtils.getMinuteFromTime(time);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute)
            .add(Duration(minutes: -5));

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

playAlarm() async {
  // DateTime now = DateTime.now();
  // bool isBefore = prayerTime.isBefore(now);

  // Play Azan ...
  print('ALARM FUNCTION !!');

  // Future.delayed(Duration.zero, () async {
  //     await AndroidAlarmManager.cancel(id);
  //   });

  // if(isBefore){
  //   DateTime tmpDate = prayerTime.add(Duration(days: 1));
  //   Future.delayed(Duration.zero, () async {
  //     await AndroidAlarmManager.oneShotAt(tmpDate, id, playAlarm(id,prayerTime));
  //   });
  // }else{
  //   Future.delayed(Duration.zero, () async {
  //     await AndroidAlarmManager.oneShotAt(prayerTime, id, playAlarm(id,prayerTime));
  //   });
  // }
}
