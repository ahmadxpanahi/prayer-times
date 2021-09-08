import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_bloc.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_event.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_state.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingBloc(),
      child: SettingContainer(),
    );
  }
}

class SettingContainer extends StatefulWidget {
  const SettingContainer({Key? key}) : super(key: key);

  @override
  _SettingContainerState createState() => _SettingContainerState();
}

class _SettingContainerState extends State<SettingContainer> {
  late bool morningAzan, noonAzan, afternoonAzan, eveningAzan, nightAzan;
  late bool morningPrayerReminder, noonPrayerReminder, afternoonPrayerReminder;
  late bool reminderActivator;
  SharedPreferences? sp;
  late SettingBloc _settingBloc;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
          'channelId', 'channelName', 'channelDescription'));

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _settingBloc = BlocProvider.of<SettingBloc>(context);
    setState(() {
      Future.delayed(Duration(milliseconds: 100), () async {
        sp = await SharedPreferences.getInstance();
        morningAzan = sp?.getBool('morning') ?? false;
        noonAzan = sp?.getBool('noon') ?? false;
        afternoonAzan = sp?.getBool('afternoon') ?? false;
        eveningAzan = sp?.getBool('evening') ?? false;
        nightAzan = sp?.getBool('night') ?? false;
        morningPrayerReminder = sp?.getBool('morningPrayerReminder') ?? false;
        noonPrayerReminder = sp?.getBool('noonPrayerReminder') ?? false;
        afternoonPrayerReminder =
            sp?.getBool('afternoonPrayerReminder') ?? false;
        reminderActivator = sp?.getBool('reminderActivator') ?? false;
      });
    });
  }

  Widget _topContainer() => Expanded(
        flex: 11,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _settingItem('Morning azan', 'everyday', 'sabahEzani'),
              _settingItem('Noon azan', 'everyday', 'ogleEzani'),
              _settingItem('Afternoon azan', 'everyday', 'ikindiEzani'),
              _settingItem('Evening azan', 'everyday', 'aksamEzani'),
              _settingItem('Night azan', 'everyday', 'yatsiEzani'),
            ],
          ),
        ),
      );

  Widget _bottomContainer() => Expanded(
        flex: 10,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _settingItem('Reminder of morning prayer', 'everyday',
                    'sabahNamaziRemmember'),
                _settingItem('Reminder of noon prayer', 'everyday',
                    'ogleNamaziRemmember'),
                _settingItem('Reminder of Afternoon prayer', 'everyday',
                    'ikindiNamaziRemmember'),
                Divider(
                  color: Colors.black,
                ),
                _bottomSettingItem('activeRemmembers')
              ],
            )),
      );

  Widget _bottomSettingItem(spKey) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale: SizeConfig.heightMultiplier! < 6 ? 0.6 : 1,
            child: CupertinoSwitch(
                value: sp?.getBool(spKey) ?? false,
                onChanged: (value) {
                  setState(() {
                    sp?.setBool(spKey, value);
                    print(sp?.getBool(spKey));
                  });
                }),
          ),
          SizedBox(
            width: SizeConfig.heightMultiplier! > 6 ? 3.0.rw : 2.2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reminder activator',
                style: TextStyle(
                    fontSize:
                        SizeConfig.heightMultiplier! < 6 ? 3.2.rw : 4.5.rw,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Lorem Ipsum is simply dummy',
                style: TextStyle(
                    fontSize:
                        SizeConfig.heightMultiplier! < 6 ? 3.0.rw : 4.2.rw,
                    color: Colors.grey),
              ),
            ],
          ),
        ],
      );

  Widget _settingItem(title, subTitle, spKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier! < 6 ? 3.2.rw : 4.5.rw,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier! < 6 ? 3.0.rw : 4.2.rw,
                  color: Colors.grey),
            ),
          ],
        ),
        Transform.scale(
          scale: SizeConfig.heightMultiplier! < 6 ? 0.6 : 1,
          child: CupertinoSwitch(
              value: sp?.getBool(spKey) ?? false,
              onChanged: (value) {
                setState(() {
                  sp?.setBool(spKey, value);
                  print(sp?.getBool(spKey));
                });
              }),
        )
      ],
    );
  }

  _buildBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 4.5.rw),
        color: PColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0.rh),
              child: Text(
                'Azan',
                style: TextStyle(
                    fontSize:
                        SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                    color: Colors.grey),
              ),
            ),
            _topContainer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0.rh),
              child: GestureDetector(
                onTap: () async {
                  // const AndroidNotificationDetails
                  //     androidPlatformChannelSpecifics =
                  //     AndroidNotificationDetails('your channel id',
                  //         'your channel name', 'your channel description',
                  //         importance: Importance.max,
                  //         priority: Priority.high,
                  //         ticker: 'ticker');
                  // const NotificationDetails platformChannelSpecifics =
                  //     NotificationDetails(
                  //         android: androidPlatformChannelSpecifics);
                  // await flutterLocalNotificationsPlugin?.show(
                  //     0, 'plain title', 'plain body', platformChannelSpecifics,
                  //     payload: 'item x');

                  await flutterLocalNotificationsPlugin?.zonedSchedule(
                      0,
                      'daily scheduled notification title',
                      'daily scheduled notification body',
                      _nextInstanceOfTenAM(),
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
                },
                child: Text(
                  'Reminders',
                  style: TextStyle(
                      fontSize:
                          SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                      color: Colors.grey),
                ),
              ),
            ),
            _bottomContainer()
          ],
        ),
      );

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 20, 16);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (_, event) {
        if (event is SaveSettingEvent) {
          setState(() {});
        }
      },
      child: _buildBody(),
    );
  }
}
