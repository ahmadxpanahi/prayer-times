import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_bloc.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_event.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_state.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:prayer_times_flutter/src/utils/gregorian_month.dart';
import 'package:prayer_times_flutter/src/utils/hour_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_builder/timer_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: HomeContainer(),
    );
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late HomeBloc _homeBloc;

  var hijriDate = HijriCalendar.fromDate(DateTime.now());

  int? hStatus;

  SharedPreferences? sp;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      sp = await SharedPreferences.getInstance();
    });
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetHomeData());
    Future.delayed(Duration(milliseconds: 1500), () async {});
  }

  Widget _itemsList(morning, sunrise, noon, afternoon, evening, night) =>
      Column(
        children: [
          _item('Morning'.i18n, morning, hStatus == 0 ? true : false),
          _item('Sunrise'.i18n, sunrise, hStatus == 1 ? true : false),
          _item('Noon'.i18n, noon, hStatus == 2 ? true : false),
          _item('Afternoon'.i18n, afternoon, hStatus == 3 ? true : false),
          _item('Evening'.i18n, evening, hStatus == 4 ? true : false),
          _item('Night'.i18n, night, hStatus == 5 ? true : false),
        ],
      );

  Widget _item(title, time, selected) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.1.rh, horizontal: 1.3.rw),
            color: selected
                ? PColors.primary!.withOpacity(0.7)
                : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 4.5.rw, color: Colors.black)),
                Text(time,
                    style: TextStyle(fontSize: 4.5.rw, color: Colors.black)),
              ],
            ),
          ),
          Container(
            height: 0.3,
            color: Colors.black,
          )
        ],
      );

  Widget _topContainer(countryName, cityName) => Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.5.rw),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: PColors.primary!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    countryName ?? '',
                    style: TextStyle(fontSize: 4.5.rw, color: Colors.black),
                  ),
                  Text(
                    cityName ?? '',
                    style: TextStyle(
                        fontSize: 6.8.rw,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${DateTime.now().day} ${GregorianMonth.monthName[DateTime.now().month]} ${DateTime.now().year}',
                    style: TextStyle(fontSize: 4.0.rw, color: Colors.black),
                  ),
                  Text(
                    '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear}',
                    style: TextStyle(
                      fontSize: 4.0.rw,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${'time'.i18n} ${DateTime.now().hour.timePadded}:${DateTime.now().minute.timePadded}:${DateTime.now().second.timePadded}',
                    style: TextStyle(
                      fontSize: 4.0.rw,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _bottomContainer(morning, sunrise, noon, afternoon, evening, night) =>
      Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.3.rw),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: PColors.primary!),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Now it\'s ${hourStatusName(hStatus)} time'.i18n,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 6.6.rw,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 0.3,
                  color: Colors.black,
                ),
                _itemsList(morning, sunrise, noon, afternoon, evening, night),
                Text(
                  '${hourStatusName(hStatus == 5 ? 0 : hStatus! + 1)}'.i18n,
                  style: TextStyle(
                    fontSize: 4.3.rw,
                    color: Colors.black,
                  ),
                ),
                TimerBuilder.periodic(Duration(seconds: 1), builder: (_) {
                  return Text(
                    '${DateTime.now().hour.timePadded}:${DateTime.now().minute.timePadded}:${DateTime.now().second.timePadded}',
                    style: TextStyle(
                        fontSize: 8.1.rw, fontWeight: FontWeight.bold),
                  );
                }),
              ],
            ),
          ));

  Widget _buildBody(morning, sunrise, noon, afternoon, evening, night,
          countryName, cityName) =>
      Container(
        color: PColors.background,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(3.0.rw),
            margin: EdgeInsets.symmetric(vertical: 3.0.rh),
            color: Colors.white,
            child: Column(
              children: [
                _topContainer(countryName, cityName),
                SizedBox(
                  height: 1.2.rh,
                ),
                _bottomContainer(
                    morning, sunrise, noon, afternoon, evening, night),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (_, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is HomeGetDataSuccess) {
            hStatus = hourStatus(
              state.morningPrayer,
              state.sunrisePrayer,
              state.noonPrayer,
              state.afternoonPrayer,
              state.eveningPrayer,
              state.nightPrayer,
            );

            return _buildBody(
                state.morningPrayer,
                state.sunrisePrayer,
                state.noonPrayer,
                state.afternoonPrayer,
                state.eveningPrayer,
                state.nightPrayer,
                state.countryName,
                state.cityName);
          } else if (state is HomeGetDataError) {
            return Center(
              child: Text(state.error),
            );
          }

          return SizedBox();
        });
  }
}
