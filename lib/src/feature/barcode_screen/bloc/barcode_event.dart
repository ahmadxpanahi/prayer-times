import 'package:equatable/equatable.dart';

abstract class BarcodeEvent extends Equatable{}

class GetBarcodeData extends BarcodeEvent{
  @override
  List<Object?> get props =>[];

}

class ShowBarcodeLoading extends BarcodeEvent{
  @override
  List<Object?> get props => [];

}

class ShowBarcodeError extends BarcodeEvent{
  @override
  List<Object?> get props => [];

}
