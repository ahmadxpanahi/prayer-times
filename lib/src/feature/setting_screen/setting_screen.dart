import 'package:flutter/cupertino.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _val = true;

  Widget _topContainer() => Expanded(
        flex: 11,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _settingItem('Sabah Ezani', 'Her gun'),
                  _settingItem('Ogle Ezani', 'Her gun'),
                  _settingItem('Ikindi Ezani', 'Her gun'),
                  _settingItem('Aksam Ezani', 'Her gun'),
                  _settingItem('Yatsi Ezani', 'Her gun'),
                ],
              ),),
      );

  Widget _bottomContainer() => Expanded(
        flex: 10,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _settingItem('Sabah Namazi Hatirtamasi', 'Her gun'),
                _settingItem('Ogle Namazi Hatirtamasi', 'Her gun'),
                _settingItem('Ikindi Namazi Hatirtamasi', 'Her gun'),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: SizeConfig.heightMultiplier! < 6 ? 0.6 : 1,
                      child: CupertinoSwitch(
                          value: _val,
                          onChanged: (value) {
                            setState(() {
                              _val = value;
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
                          'Lorem Ipsum',
                          style: TextStyle(
                              fontSize: SizeConfig.heightMultiplier! < 6 ? 3.2.rw : 4.5.rw, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text',
                          style:
                              TextStyle(fontSize: SizeConfig.heightMultiplier! < 6 ? 3.0.rw : 4.2.rw, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      );

  Widget _settingItem(
    title,
    subTitle,
  ) {
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
              value: _val,
              onChanged: (value) {
                setState(() {
                  _val = value;
                });
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.5.rw),
      color: PColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0.rh),
            child: Text(
              'Ezaniar',
              style: TextStyle(fontSize: SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw, color: Colors.grey),
            ),
          ),
          _topContainer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0.rh),
            child: Text(
              'Lorem Ipsum is simply dummy',
              style: TextStyle(fontSize: SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw, color: Colors.grey),
            ),
          ),
          _bottomContainer()
        ],
      ),
    );
  }
}
