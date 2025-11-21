part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UploadPhotoEvent extends HomeEvent {
  final String filePath;

  const UploadPhotoEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class LoadRecentPhotosEvent extends HomeEvent {}
