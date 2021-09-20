import 'package:equatable/equatable.dart';

enum HorizonType { Morning, Noon, Afternoon, Sunset, Night }

enum ActionType { Enable, Disable }

abstract class SettingEvent extends Equatable {}

class ToggleAlarm extends SettingEvent {
  HorizonType horizonType;
  ActionType actionType;
  ToggleAlarm(this.horizonType,this.actionType);

  @override
  List<Object?> get props => [this.horizonType,this.actionType];
}

class ToggleNotification extends SettingEvent {
  HorizonType horizonType;
  ActionType actionType;

  ToggleNotification(this.horizonType, this.actionType);

  @override
  List<Object?> get props => [this.horizonType, this.actionType];
}
