import 'package:bloc/bloc.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_event.dart';
import 'package:prayer_times_flutter/src/feature/setting_screen/bloc/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent,SettingState>{

  SettingBloc() : super(SettingInitialState());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if(event is SaveSettingEvent){
      yield SettingSaveState();
    }
  }

}
