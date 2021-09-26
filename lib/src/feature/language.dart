import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:prayer_times_flutter/src/core/preferences_manager.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/main_screen.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String _singleValue = 'English';
  SharedPreferences? sp;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
     sp = await SharedPreferences.getInstance();
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0.rw),
          height: 50.0.rh,
          decoration: BoxDecoration(
              border: Border.all(color: PColors.primary!, width: 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Language',
                style: TextStyle(fontSize: 30, color: PColors.primary),
              ),
              SizedBox(
                height: 4.0.rh,
              ),
              RadioButton(
                description: "English",
                value: "English",
                activeColor: PColors.primary,
                groupValue: _singleValue,
                onChanged: (_)async {
                  setState(() {
                    _singleValue = 'English';
                  });
                }
              ),
              RadioButton(
                description: "Greek",
                value: "Greek",
                activeColor: PColors.primary,
                groupValue: _singleValue,
                onChanged: (_)async {
                  setState(() {
                    _singleValue = 'Greek';
                  });
                }
              ),
              RadioButton(
                description: "Turkish",
                value: "Turkish",
                activeColor: PColors.primary,
                groupValue: _singleValue,
                onChanged: (_)async {
                  setState(() {
                    _singleValue = 'Turkish';
                  });
                }
              ),
              SizedBox(
                height: 4.0.rh,
              ),
              GestureDetector(
                onTap: () async {
                  await sp?.setString(PreferencesManager.LANGUAGE, _singleValue);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen('home')));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 6.0.rh,
                  width: 30.0.rw,
                  decoration: BoxDecoration(
                    color: PColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 5.0.rw),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.rh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
