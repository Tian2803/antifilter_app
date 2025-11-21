import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/usecases/upload_photo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UploadPhoto uploadPhoto;

  HomeBloc({
    required this.uploadPhoto,
  }) : super(HomeInitial()) {
    on<UploadPhotoEvent>(_onUploadPhoto);
    on<LoadRecentPhotosEvent>(_onLoadRecentPhotos);
  }

  Future<void> _onUploadPhoto(
    UploadPhotoEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final photo = await uploadPhoto(event.filePath);
      emit(PhotoUploaded(photo));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadRecentPhotos(
    LoadRecentPhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      // TODO: Implement loading recent photos
      emit(const PhotosLoaded([]));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
