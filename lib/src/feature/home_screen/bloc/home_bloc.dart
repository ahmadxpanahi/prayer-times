import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/core/preferences_manager.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_event.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SharedPreferences? sp;

  HomeBloc() : super(HomeInitialState()) {
    Future.delayed(Duration.zero, () async {
      this.sp = await SharedPreferences.getInstance();
    });
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetHomeData) {
      yield* _getHomeData();
    } else if (event is ShowHomeLoading) {
      yield HomeLoadingState();
    }
  }

  Stream<HomeState> _getHomeData() async* {
    yield HomeLoadingState();
    
    try {

      final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
      final position = await _geolocatorPlatform.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      var cityName = placemarks[0].street;
      var countryName = placemarks[0].country;

      var url =
          Uri.parse('https://api.pray.zone/v2/times/today.json?longitude=${position.longitude}&latitude=${position.latitude}&elevation=333');
      var response = await http.get(url);

      Map times = json.decode(response.body)['results']['datetime'][0]['times'];
      Map info = json.decode(response.body)['results']['location'];
      Map dates = json.decode(response.body)['results']['datetime'][0]['date'];

      print(json.decode(response.body)['results']);

      await _savePrayerTimes(times);

      yield HomeGetDataSuccess(
          morningPrayer: times['Imsak'] == '-' ? '00:00' : times['Imsak'],
          sunrisePrayer: times['Sunrise'] == '-' ? '00:00' : times['Sunrise'],
          noonPrayer: times['Dhuhr'] == '-' ? '00:00' : times['Dhuhr'],
          afternoonPrayer: times['Asr'] == '-' ? '00:00' : times['Asr'],
          eveningPrayer: times['Maghrib'] == '-' ? '00:00' : times['Maghrib'],
          nightPrayer: times['Isha'] == '-' ? '00:00' : times['Isha'],
          cityName: cityName,
          countryName: countryName,
          gregorianDate: dates['gregorian'],
          hijriDate: dates['hijri']);
    } on SocketException catch (e) {
      yield HomeGetDataError("Please check your network connection");
    } on FormatException catch (e) {
      yield HomeGetDataError("Prayer times server is down! please try again later");
    } on Exception catch(e){
      yield HomeGetDataError(e.toString());
    }
  }

  Future<void> _savePrayerTimes(Map times) async {
    await sp?.setString(PreferencesManager.MORNING_PRAYER_TIME, times['Imsak']);
    await sp?.setString(PreferencesManager.NOON_PRAYER_TIME, times['Dhuhr']);
    await sp?.setString(PreferencesManager.AFTERNOON_PRAYER_TIME, times['Asr']);
    await sp?.setString(
        PreferencesManager.SUNSET_PRAYER_TIME, times['Maghrib']);
    await sp?.setString(PreferencesManager.NIGHT_PRAYER_TIME, times['Isha']);
  }
}
