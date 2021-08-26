import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prayer times flutter',
      home: MainScreen()
    );
  }
}
