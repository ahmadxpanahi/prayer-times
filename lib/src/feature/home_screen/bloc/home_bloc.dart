import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_event.dart';
import 'package:prayer_times_flutter/src/feature/home_screen/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) {
    throw UnimplementedError();
  }

}
