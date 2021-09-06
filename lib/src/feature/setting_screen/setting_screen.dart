import 'package:flutter/cupertino.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_bloc.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_event.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_state.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({ Key? key }) : super(key: key);

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
  
  late bool sabahEzani,ogleEzani,ikindiEzani,aksamEzani,yatsiEzani;
  late bool sabahNamaziRemmember,ogleNamaziRemmember,ikindiNamaziRemmember;
  late bool activeRemmembers;
  SharedPreferences? sp;
  late SettingBloc _settingBloc;
  
  @override
  void initState() {
    super.initState();

    _settingBloc = BlocProvider.of<SettingBloc>(context);
    setState(() {
      Future.delayed(Duration(milliseconds: 100),() async {
      sp = await SharedPreferences.getInstance();
      sabahEzani = sp?.getBool('sabahEzani') ?? false;
      ogleEzani = sp?.getBool('ogleEzani') ?? false;
      ikindiEzani = sp?.getBool('ikindiEzani') ?? false;
      aksamEzani = sp?.getBool('aksamEzani') ?? false;
      yatsiEzani = sp?.getBool('yatsiEzani') ?? false;
      sabahNamaziRemmember = sp?.getBool('sabahNamaziRemmember') ?? false;
      ogleNamaziRemmember = sp?.getBool('ogleNamaziRemmember') ?? false;
      ikindiNamaziRemmember = sp?.getBool('ikindiNamaziRemmember') ?? false;
      activeRemmembers = sp?.getBool('activeRemmembers') ?? false;
    }
    );
    });
  }

  Widget _topContainer() => Expanded(
        flex: 11,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _settingItem('Sabah Ezani', 'Her gun','sabahEzani'),
              _settingItem('Ogle Ezani', 'Her gun','ogleEzani'),
              _settingItem('Ikindi Ezani', 'Her gun','ikindiEzani'),
              _settingItem('Aksam Ezani', 'Her gun','aksamEzani'),
              _settingItem('Yatsi Ezani', 'Her gun','yatsiEzani'),
            ],
          ),
        ),
      );

  Widget _bottomContainer() => Expanded(
        flex: 10,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.2.rw),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _settingItem('Sabah Namazi Hatirtamasi', 'Her gun','sabahNamaziRemmember'),
                _settingItem('Ogle Namazi Hatirtamasi', 'Her gun','ogleNamaziRemmember'),
                _settingItem('Ikindi Namazi Hatirtamasi', 'Her gun','ikindiNamaziRemmember'),
                Divider(
                  color: Colors.black,
                ),
                _bottomSettingItem('activeRemmembers')
              ],
            )),
      );

  Widget _bottomSettingItem(spKey) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: SizeConfig.heightMultiplier! < 6 ? 0.6 : 1,
                      child: CupertinoSwitch(
                          value: sp?.getBool(spKey)??false,
                          onChanged: (value) {
                            setState((){
                              sp?.setBool(spKey, value);
                              print(sp?.getBool(spKey));
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
                          'Hatirlatmalar aktif',
                          style: TextStyle(
                              fontSize: SizeConfig.heightMultiplier! < 6
                                  ? 3.2.rw
                                  : 4.5.rw,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy',
                          style: TextStyle(
                              fontSize: SizeConfig.heightMultiplier! < 6
                                  ? 3.0.rw
                                  : 4.2.rw,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                );

  Widget _settingItem(
    title,
    subTitle,
    spKey
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
              value: sp?.getBool(spKey)??false,
              onChanged: (value) {
                setState((){
                  sp?.setBool(spKey, value);
                  print(sp?.getBool(spKey));
                });
              }),
        )
      ],
    );
  }

  _buildBody() => Container(
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
              style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                  color: Colors.grey),
            ),
          ),
          _topContainer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0.rh),
            child: Text(
              'Lorem Ipsum is simply dummy',
              style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier! > 6 ? 4.3.rw : 3.3.rw,
                  color: Colors.grey),
            ),
          ),
          _bottomContainer()
        ],
      ),
    );

  @override
  Widget build(BuildContext context){

    return BlocListener<SettingBloc,SettingState>(
      listener: (_,event){
        if(event is SaveSettingEvent){
          setState(() {});
        }
      },
      child: _buildBody(),
    );
  }
}
