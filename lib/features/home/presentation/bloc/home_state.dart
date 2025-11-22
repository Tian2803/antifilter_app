part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeEmpty extends HomeState {}

class PhotosLoaded extends HomeState {
  final List<PhotoEntity> photos;

  const PhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
