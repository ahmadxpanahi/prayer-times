import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable{}

class SettingInitialState extends SettingState{

  @override
  List<Object?> get props =>[];

}

class AlarmToggled extends SettingState{
  @override
  List<Object?> get props => [Random().nextInt(99)];
}

class NotificationToggled extends SettingState{
  @override
  List<Object?> get props => [Random().nextInt(99)];
}