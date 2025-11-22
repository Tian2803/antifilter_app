part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteEmpty extends FavoriteState {}

class FavoritePhotosLoaded extends FavoriteState {
  final List<FavoritePhotoEntity> photos;

  const FavoritePhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
