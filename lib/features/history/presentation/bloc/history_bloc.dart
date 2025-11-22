import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/history_photo_entity.dart';
import '../../domain/usecases/get_all_photos.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetAllPhotos getAllPhotos;

  HistoryBloc({required this.getAllPhotos}) : super(HistoryInitial()) {
    on<LoadAllPhotosEvent>(_onLoadAllPhotos);
  }

  Future<void> _onLoadAllPhotos(
    LoadAllPhotosEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final photos = await getAllPhotos();
      if (photos.isEmpty) {
        emit(HistoryEmpty());
      } else {
        emit(HistoryPhotosLoaded(photos));
      }
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
