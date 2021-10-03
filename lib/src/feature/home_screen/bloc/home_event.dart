import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class ShowHomeLoading extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class GetHomeData extends HomeEvent{
  @override
  List<Object?> get props => [];

}
