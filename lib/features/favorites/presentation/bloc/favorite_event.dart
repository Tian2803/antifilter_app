part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadAllPhotosEvent extends FavoriteEvent {
  const LoadAllPhotosEvent();
}
