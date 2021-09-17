import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_event.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_state.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is GetHomeData){
      yield* _getHomeData();
    }else if(event is ShowHomeLoading){
      yield HomeLoadingState();
    }
  }

  Stream<HomeState> _getHomeData() async* {

    yield HomeLoadingState();
    
    try{

      var url = Uri.parse('https://api.pray.zone/v2/times/today.json?city=athens');
      var response = await http.get(url);

      Map times = json.decode(response.body)['results']['datetime'][0]['times'];
      Map info = json.decode(response.body)['results']['location'];
      Map dates = json.decode(response.body)['results']['datetime'][0]['date'];

      // print(response.body);

      yield HomeGetDataSuccess(
        morningPrayer: times['Imsak'],
        sunrisePrayer: times['Sunrise'],
        noonPrayer: times['Dhuhr'],
        afternoonPrayer: times['Asr'],
        eveningPrayer: '09:45',
        nightPrayer: times['Isha'],
        cityName: info['city'],
        countryName: info['country'],
        gregorianDate: dates['gregorian'],
        hijriDate: dates['hijri']
      );

    }on SocketException catch (e){
      print(e);
    }

  }

}
