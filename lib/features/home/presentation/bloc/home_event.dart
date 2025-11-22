part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadRecentPhotosEvent extends HomeEvent {
  final int limit;

  const LoadRecentPhotosEvent({this.limit = 3});

  @override
  List<Object> get props => [limit];
}
