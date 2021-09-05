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
      this.asrPrayer,
      this.dhuhrPrayer,
      this.imsakPrayer,
      this.ishaPrayer,
      this.gregorianDate,
      this.maghribPrayer,
      this.hijriDate,
      this.sunrisePrayer});

  final String? countryName;
  final String? cityName;
  final String? imsakPrayer;
  final String? sunrisePrayer;
  final String? dhuhrPrayer;
  final String? asrPrayer;
  final String? maghribPrayer;
  final String? ishaPrayer;
  final String? gregorianDate;
  final String? hijriDate;

  @override
  List<Object?> get props => [
        countryName,
        cityName,
        imsakPrayer,
        sunrisePrayer,
        dhuhrPrayer,
        asrPrayer,
        maghribPrayer,
        hijriDate,
        ishaPrayer,
        gregorianDate
      ];
}
