import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/barcode_screen.dart';
import 'package:prayer_times_flutter/src/feature/calendar_screen/calendar_screen.dart';
import 'package:prayer_times_flutter/src/feature/food_list_screen/food_list_screen.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/home_screen.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/widget/bottom_nav.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/setting_screen.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/ui/dialog.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:i18n_extension/i18n_extension.dart';

class MainScreen extends StatefulWidget {
  String? screenName;
  MainScreen(this.screenName, {Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SharedPreferences? ps;
  String _singleValue = "Greek";
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      ps = await SharedPreferences.getInstance();
    });
    Future.delayed(Duration(milliseconds: 2000), () {
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> screens = {
      'home': HomeScreen(),
      'barcode': FoodListScreen(),
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
            'Home Page'.i18n,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Halal product scanning'.i18n,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
                ),
              ],
            )),
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
            'Setting'.i18n,
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
            'Religious days'.i18n,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 2.73.rt, color: Colors.white),
          ),
        ),
      ),
    };

    return Scaffold(
      body: screens[widget.screenName],
      appBar: appbars[widget.screenName],
      bottomNavigationBar: PBottomNavigation(
        screenName: widget.screenName,
        change: (String scName) {
          setState(() {
            widget.screenName = scName;
          });
        },
      ),
    );
  }
}
