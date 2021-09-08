
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/barcode_screen.dart';
import 'package:prayer_times_flutter/src/feature/calendar/calendar_screen.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/home_screen.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/widget/bottom_nav.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/setting_screen.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:timezone/timezone.dart' as tz;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _screenName = 'home';

  Map<String, Widget> screens = {
    'home': HomeScreen(),
    'barcode': BarcodeScreen(),
    'setting': SettingScreen(),
    'calendar': CalendarScreen(),
  };

  Map<String, PreferredSize> appbars = {
    'home': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 5.5.rh : 4.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Home Page',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
    'barcode': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 5.5.rh : 4.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Halal product scanning',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
    'setting': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 5.5.rh : 4.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Setting',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
    'calendar': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 5.5.rh : 4.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Religious days',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
  };

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
    DateTime.now().day, 12, 52, 0);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        "A Notification From My App",
        "This notification is brought to you by Local Notifcations Package",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 20))      ,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION')),
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
                matchDateTimeComponents: DateTimeComponents.time
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_screenName],
      appBar: appbars[_screenName],
      bottomNavigationBar: PBottomNavigation(
        screenName: _screenName,
        change: (String scName) {
          setState(() {
            _screenName = scName;
          });
        },
      ),
    );
  }
}
