import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/usecases/get_recent_photos.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecentPhotos getRecentPhotos;

  HomeBloc({required this.getRecentPhotos}) : super(HomeInitial()) {
    on<LoadRecentPhotosEvent>(_onLoadRecentPhotos);
  }

  Future<void> _onLoadRecentPhotos(
    LoadRecentPhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final photos = await getRecentPhotos(event.limit);
      if (photos.isEmpty) {
        emit(HomeEmpty());
      } else {
        emit(PhotosLoaded(photos));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
