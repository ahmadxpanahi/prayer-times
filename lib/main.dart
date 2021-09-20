import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/main_screen.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/core/notification_service.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();
  await NotificationService().init();

  await AndroidAlarmManager.initialize();  

  runApp(MyApp());

  
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      SharedPreferences sp = await SharedPreferences.getInstance();
    });
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
                routes: {
                  '/foods' : (context) => MainScreen('barcode')
                },
                theme: ThemeData(
                  primaryColor: PColors.primary,
                  backgroundColor: PColors.primary
                ),
                debugShowCheckedModeBanner: false,
                title: 'Prayer times flutter',
                home: MainScreen('home'));
          },
        );
      },
    );
  }
}
