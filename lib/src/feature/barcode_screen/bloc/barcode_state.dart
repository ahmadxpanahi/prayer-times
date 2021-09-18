import 'package:equatable/equatable.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';

abstract class BarcodeState extends Equatable{}

class BarcodeInitialState extends BarcodeState{
  @override
  List<Object?> get props => [];

}

class GetBarcodeDataSuccess extends BarcodeState{
  final List<Food> foods;
  GetBarcodeDataSuccess(this.foods);
  @override
  List<Object?> get props => [foods];

}

class BarcodeErrorState extends BarcodeState{
  String? error;
  BarcodeErrorState({this.error});
  @override
  List<Object?> get props =>[error];

}

class BarcodeLoadingState extends BarcodeState{
  @override
  List<Object?> get props =>[];

}