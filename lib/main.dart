import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/main_screen.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/core/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
    });
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Prayer times flutter',
                home: MainScreen());
          },
        );
      },
    );
  }
}
