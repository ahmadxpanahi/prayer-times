import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:prayer_times_flutter/src/core/preferences_manager.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_bloc.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_event.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_state.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';

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
  bool? morningAzan, noonAzan, afternoonAzan, eveningAzan, nightAzan;
  bool? morningPrayerReminder, noonPrayerReminder, afternoonPrayerReminder;
  bool? reminderActivator;
  SharedPreferences? sp;
  late SettingBloc _settingBloc;
  String? _singleValue;

  @override
  void initState() {
    super.initState();

    _settingBloc = BlocProvider.of<SettingBloc>(context);
    _loadPrefs();
  }

  void _loadPrefs() {
    Future.delayed(Duration(milliseconds: 100), () async {
      sp = await SharedPreferences.getInstance();
      setState(() {
        _singleValue = sp?.getString(PreferencesManager.LANGUAGE);
        morningAzan = sp?.getBool(PreferencesManager.MORNING_ALARM) ?? false;
        noonAzan = sp?.getBool(PreferencesManager.NOON_ALARM) ?? false;
        afternoonAzan =
            sp?.getBool(PreferencesManager.AFTERNOON_ALARM) ?? false;
        eveningAzan = sp?.getBool(PreferencesManager.SUNSET_ALARM) ?? false;
        nightAzan = sp?.getBool(PreferencesManager.NIGHT_ALARM) ?? false;
        morningPrayerReminder =
            sp?.getBool(PreferencesManager.MORNING_NOTIFICATION) ?? false;
        noonPrayerReminder =
            sp?.getBool(PreferencesManager.NOON_NOTIFICATION) ?? false;
        afternoonPrayerReminder =
            sp?.getBool(PreferencesManager.AFTERNOON_NOTIFICATION) ?? false;
        reminderActivator =
            sp?.getBool(PreferencesManager.NOTIFICATIONS_ENABLED) ?? false;
      });
    });
  }

  Widget _topContainer() => Container(
        padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _settingItem(
              'Morning azan'.i18n,
              'everyday'.i18n,
              PreferencesManager.MORNING_ALARM,
            ),
            _settingItem(
              'Noon azan'.i18n,
              'everyday'.i18n,
              PreferencesManager.NOON_ALARM,
            ),
            _settingItem(
              'Afternoon azan'.i18n,
              'everyday'.i18n,
              PreferencesManager.AFTERNOON_ALARM,
            ),
            _settingItem(
              'Evening azan'.i18n,
              'everyday'.i18n,
              PreferencesManager.SUNSET_ALARM,
            ),
            _settingItem(
              'Night azan'.i18n,
              'everyday'.i18n,
              PreferencesManager.NIGHT_ALARM,
            ),
          ],
        ),
      );

  Widget _bottomContainer() => Container(
      padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _settingItem(
            'Reminder of Morning prayer'.i18n,
            'everyday'.i18n,
            PreferencesManager.MORNING_NOTIFICATION,
          ),
          _settingItem(
            'Reminder of Noon prayer'.i18n,
            'everyday'.i18n,
            PreferencesManager.NOON_NOTIFICATION,
          ),
          _settingItem(
            'Reminder of Afternoon prayer'.i18n,
            'everyday'.i18n,
            PreferencesManager.AFTERNOON_NOTIFICATION,
          ),
          _settingItem(
            'Reminder of Sunset prayer'.i18n,
            'everyday'.i18n,
            PreferencesManager.SUNSET_NOTIFICATION,
          ),
          _settingItem(
            'Reminder of Night prayer'.i18n,
            'everyday'.i18n,
            PreferencesManager.NIGHT_NOTIFICATION,
          ),
          // Divider(
          //   color: Colors.black,
          // ),
          // _bottomSettingItem()
        ],
      ));

  Widget _bottomSettingItem() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale: SizeConfig.heightMultiplier! < 6 ? 0.6 : 1,
            child: CupertinoSwitch(
                value: sp?.getBool(PreferencesManager.NOTIFICATIONS_ENABLED) ??
                    false,
                onChanged: (value) {
                  setState(() {
                    sp?.setBool(
                        PreferencesManager.NOTIFICATIONS_ENABLED, value);
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

  Widget _changeLanguageContainer() => Container(
        padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
        margin: EdgeInsets.only(bottom: 4.0.rh),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RadioButton(
                description: "English",
                value: "English",
                activeColor: PColors.primary,
                groupValue: _singleValue,
                onChanged: (_) async {
                  setState(() {
                    _singleValue = 'English';
                    sp?.setString(PreferencesManager.LANGUAGE, _singleValue!);
                    I18n.of(context).locale = Locale('en', "us");
                  });
                }),
            RadioButton(
                description: "Greek",
                value: "Greek",
                activeColor: PColors.primary,
                groupValue: _singleValue,
                onChanged: (_) async {
                  setState(() {
                    _singleValue = 'Greek';
                    sp?.setString(PreferencesManager.LANGUAGE, _singleValue!);
                    I18n.of(context).locale = Locale('el','gr');
                  });
                }),
            RadioButton(
                description: "Turkish",
                value: "Turkish",
                activeColor: PColors.primary,
                groupValue: _singleValue,
                onChanged: (_) async {
                  setState(() {
                    _singleValue = 'Turkish';
                    sp?.setString(PreferencesManager.LANGUAGE, _singleValue!);
                    I18n.of(context).locale = Locale('tr', "tu");
                  });
                }),
            SizedBox(
              height: 4.0.rh,
            ),
          ],
        ),
      );

  Widget _settingItem(title, subTitle, spKey) => Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 6,
          right: 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize:
                          SizeConfig.heightMultiplier! < 6 ? 3.2.rw : 4.5.rw,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      fontSize:
                          SizeConfig.heightMultiplier! < 6 ? 3.0.rw : 4.2.rw,
                      color: Colors.grey),
                ),
              ],
            ),
            Transform.scale(
              scale: SizeConfig.heightMultiplier! < 6 ? 0.6 : 1,
              child: CupertinoSwitch(
                  value: sp?.getBool(spKey) ?? false,
                  onChanged: (value) {
                    print('Switch changed to -> $value');
                    switch (spKey) {
                      case PreferencesManager.MORNING_ALARM:
                        _settingBloc.add(ToggleAlarm(
                          HorizonType.Morning,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.NOON_ALARM:
                        _settingBloc.add(ToggleAlarm(
                          HorizonType.Noon,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.AFTERNOON_ALARM:
                        _settingBloc.add(ToggleAlarm(
                          HorizonType.Afternoon,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.SUNSET_ALARM:
                        _settingBloc.add(ToggleAlarm(
                          HorizonType.Sunset,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.NIGHT_ALARM:
                        _settingBloc.add(ToggleAlarm(
                          HorizonType.Night,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.MORNING_NOTIFICATION:
                        _settingBloc.add(ToggleNotification(
                          HorizonType.Morning,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.NOON_NOTIFICATION:
                        _settingBloc.add(ToggleNotification(
                          HorizonType.Noon,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.AFTERNOON_NOTIFICATION:
                        _settingBloc.add(ToggleNotification(
                          HorizonType.Afternoon,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.SUNSET_NOTIFICATION:
                        _settingBloc.add(ToggleNotification(
                          HorizonType.Sunset,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                      case PreferencesManager.NIGHT_NOTIFICATION:
                        _settingBloc.add(ToggleNotification(
                          HorizonType.Night,
                          value ? ActionType.Enable : ActionType.Disable,
                        ));
                        break;
                    }
                    // _setAlarm(spKey, value);
                  }),
            )
          ],
        ),
      );

  _buildBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 4.5.rw),
        color: PColors.background,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.rh),
              child: Text(
                'Azan'.i18n,
                style: TextStyle(
                    fontSize:
                        SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                    color: Colors.grey),
              ),
            ),
            _topContainer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.rh),
              child: GestureDetector(
                onTap: () async {},
                child: Text(
                  'Reminders'.i18n,
                  style: TextStyle(
                      fontSize:
                          SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                      color: Colors.grey),
                ),
              ),
            ),
            _bottomContainer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.rh),
              child: GestureDetector(
                onTap: () async {},
                child: Text(
                  'Language'.i18n,
                  style: TextStyle(
                      fontSize:
                          SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                      color: Colors.grey),
                ),
              ),
            ),
            _changeLanguageContainer()
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
        listener: (_, state) {
          if (state is AlarmToggled) {
            _loadPrefs();
          } else if (state is NotificationToggled) {
            _loadPrefs();
          }
        },
        child: _buildBody());
  }
}
