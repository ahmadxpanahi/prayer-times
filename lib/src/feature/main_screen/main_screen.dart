import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/barcode_screen.dart';
import 'package:prayer_times_flutter/src/feature/calendar/calendar_screen.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/home_screen.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/widget/bottom_nav.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/setting_screen.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';

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
          'Ana Sayfa',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
    'barcode': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 3.5.rh : 2.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Helal Urun Tarama',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
    'setting': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 3.5.rh : 2.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Ayarlar',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
    'calendar': PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier! >= 7 ? 3.5.rh : 2.2.rh),
        alignment: Alignment.center,
        color: PColors.primary,
        height: 13.3.rh,
        child: Text(
          'Dini Gunler',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
        ),
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_screenName],
      appBar: appbars[_screenName],
      bottomNavigationBar: PBottomNavigation(
        screenName: _screenName,
        change: (String scName){
          setState(() {
            _screenName = scName;
          });
        },
      ),
    );
  }
}
