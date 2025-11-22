part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryPhotosLoaded extends HistoryState {
  final List<HistoryPhotoEntity> photos;

  const HistoryPhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
