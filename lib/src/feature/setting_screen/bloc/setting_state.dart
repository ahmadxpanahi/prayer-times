import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable{}

class SettingInitialState extends SettingState{

  @override
  List<Object?> get props =>[];

}

class SettingSaveState extends SettingState{
  @override
  List<Object?> get props => [];

}
