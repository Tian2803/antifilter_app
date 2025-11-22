import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/favorite_photo_entity.dart';
import '../../domain/usecases/get_all_photos.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetAllPhotosFav getAllPhotos;

  FavoriteBloc({required this.getAllPhotos}) : super(FavoriteInitial()) {
    on<LoadAllPhotosEvent>(_onLoadAllPhotos);
  }

  Future<void> _onLoadAllPhotos(
    LoadAllPhotosEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    try {
      final photos = await getAllPhotos();
      if (photos.isEmpty) {
        emit(FavoriteEmpty());
      } else {
        emit(FavoritePhotosLoaded(photos));
      }
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
