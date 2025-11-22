part of 'photo_editor_bloc.dart';

abstract class PhotoEditorEvent extends Equatable {
  const PhotoEditorEvent();

  @override
  List<Object?> get props => [];
}

class LoadPhotoEvent extends PhotoEditorEvent {
  final File imageFile;

  const LoadPhotoEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class UploadPhotoEvent extends PhotoEditorEvent {
  final File imageFile;

  const UploadPhotoEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class SaveToFavoritesEvent extends PhotoEditorEvent {
  final File imageFile;

  const SaveToFavoritesEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class ChangePhotoEvent extends PhotoEditorEvent {
  final File newImageFile;

  const ChangePhotoEvent(this.newImageFile);

  @override
  List<Object?> get props => [newImageFile];
}
