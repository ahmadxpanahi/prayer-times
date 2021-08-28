import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';

class PBottomNavigation extends StatefulWidget {
  PBottomNavigation({Key? key, this.change, this.screenName}) : super(key: key);

  String? screenName;
  Function(String)? change;

  @override
  _PBottomNavigationState createState() => _PBottomNavigationState();
}

class _PBottomNavigationState extends State<PBottomNavigation> {
  Widget _bottomNavItem(Function tap, String scName, String svgUrl,
          String checkTitle, double size) =>
      Expanded(
        child: GestureDetector(
          onTap: () {
            tap();
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SvgPicture.asset(svgUrl,
                      color:
                          scName == checkTitle ? PColors.primary : Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.rh),
      height: 8.2.rh,
      color: Colors.white,
      child: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _bottomNavItem(() {
                widget.change!('home');
              }, widget.screenName ?? '', 'assets/images/home.svg', 'home',
                  4.1.rh),
              _bottomNavItem(() {
                widget.change!('barcode');
              }, widget.screenName ?? '', 'assets/images/halal.svg', 'barcode',
                  4.5.rh),
              _bottomNavItem(() {
                widget.change!('calendar');
              }, widget.screenName ?? '', 'assets/images/calendar.svg',
                  'calendar', 4.1.rh),
              _bottomNavItem(() {
                widget.change!('setting');
              }, widget.screenName ?? '', 'assets/images/setting.svg',
                  'setting', SizeConfig.heightMultiplier! * 4), 
            ],
          ),
        ),
      ),
    );
  }
}
