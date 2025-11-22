import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/upload_photo_usecase.dart';
import '../../domain/usecases/save_to_favorites_usecase.dart';

part 'photo_editor_event.dart';
part 'photo_editor_state.dart';

class PhotoEditorBloc extends Bloc<PhotoEditorEvent, PhotoEditorState> {
  final UploadPhotoUseCase uploadPhotoUseCase;
  final SaveToFavoritesUseCase saveToFavoritesUseCase;

  String? _currentPhotoId;

  PhotoEditorBloc({
    required this.uploadPhotoUseCase,
    required this.saveToFavoritesUseCase,
  }) : super(PhotoEditorInitial()) {
    on<LoadPhotoEvent>(_onLoadPhoto);
    on<UploadPhotoEvent>(_onUploadPhoto);
    on<SaveToFavoritesEvent>(_onSaveToFavorites);
    on<ChangePhotoEvent>(_onChangePhoto);
  }

  void _onLoadPhoto(LoadPhotoEvent event, Emitter<PhotoEditorState> emit) {
    emit(PhotoLoaded(event.imageFile));
  }

  Future<void> _onUploadPhoto(
    UploadPhotoEvent event,
    Emitter<PhotoEditorState> emit,
  ) async {
    emit(PhotoEditorLoading());

    try {
      final photoId = await uploadPhotoUseCase(
        UploadPhotoParams(imageFile: event.imageFile),
      );
      _currentPhotoId = photoId;
      emit(
        PhotoUploaded(
          photoId: photoId,
          message: 'photoEditor.saveHistory'.tr(),
        ),
      );
    } catch (e) {
      emit(PhotoEditorError(e.toString()));
    }
  }

  Future<void> _onSaveToFavorites(
    SaveToFavoritesEvent event,
    Emitter<PhotoEditorState> emit,
  ) async {
    try {
      await saveToFavoritesUseCase(event.imageFile);
      emit(SavedToFavorites('photoEditor.saveFavorites'.tr()));
    } catch (e) {
      emit(PhotoEditorError(e.toString()));
    }
  }

  void _onChangePhoto(ChangePhotoEvent event, Emitter<PhotoEditorState> emit) {
    emit(PhotoLoaded(event.newImageFile));
  }

  String? get currentPhotoId => _currentPhotoId;
}
