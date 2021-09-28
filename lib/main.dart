import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:prayer_times_flutter/src/core/preferences_manager.dart';
import 'package:prayer_times_flutter/src/feature/language.dart';
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

  SharedPreferences? sp;
  var languageValue;
  Locale? initialLocale;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      sp = await SharedPreferences.getInstance();
      languageValue = sp?.getString(PreferencesManager.LANGUAGE);
      switch(languageValue){
        case 'English' : initialLocale = Locale('en', "us"); break;
        case 'Greek' : initialLocale = Locale('el','gr'); break;
        case 'Turkish' : initialLocale = Locale('tr', "tu"); break;
      }
      print(initialLocale);
    });

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig().init(constraints, orientation);
            return I18n(
              id: '1',
              initialLocale: Locale('en', "us"),
              child: MaterialApp(
                  supportedLocales: [
                    const Locale('en', "us"),
                    const Locale('tr', "tu"),
                    const Locale('el','gr'),
                  ],
                  localizationsDelegates: [],
                  routes: {
                    '/foods': (context) => MainScreen('barcode')
                  },
                  theme: ThemeData(
                      primaryColor: PColors.primary,
                      backgroundColor: PColors.primary),
                  debugShowCheckedModeBanner: false,
                  title: 'Prayer times flutter',
                  home:
                      languageValue != null ? Language() : MainScreen('home')),
            );
          },
        );
      },
    );
  }
}
