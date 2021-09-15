import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeGetDataSuccess extends HomeState {
  HomeGetDataSuccess(
      {this.countryName,
      this.cityName,
      this.afternoonPrayer,
      this.noonPrayer,
      this.morningPrayer,
      this.nightPrayer,
      this.gregorianDate,
      this.eveningPrayer,
      this.hijriDate,
      this.sunrisePrayer});

  final String? countryName;
  final String? cityName;
  final String? morningPrayer;
  final String? sunrisePrayer;
  final String? noonPrayer;
  final String? afternoonPrayer;
  final String? eveningPrayer;
  final String? nightPrayer;
  final String? gregorianDate;
  final String? hijriDate;

  @override
  List<Object?> get props => [
        countryName,
        cityName,
        morningPrayer,
        sunrisePrayer,
        noonPrayer,
        afternoonPrayer,
        eveningPrayer,
        hijriDate,
        nightPrayer,
        gregorianDate
      ];
}

class HomeGetDataError extends HomeState {
  String error;

  HomeGetDataError(this.error);

  @override  
  List<Object?> get props => [error];
}