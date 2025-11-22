part of 'photo_editor_bloc.dart';

abstract class PhotoEditorState extends Equatable {
  const PhotoEditorState();

  @override
  List<Object?> get props => [];
}

class PhotoEditorInitial extends PhotoEditorState {}

class PhotoEditorLoading extends PhotoEditorState {}

class PhotoLoaded extends PhotoEditorState {
  final File imageFile;

  const PhotoLoaded(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class PhotoUploaded extends PhotoEditorState {
  final String photoId;
  final String message;

  const PhotoUploaded({required this.photoId, required this.message});

  @override
  List<Object?> get props => [photoId, message];
}

class SavedToFavorites extends PhotoEditorState {
  final String message;

  const SavedToFavorites(this.message);

  @override
  List<Object?> get props => [message];
}

class PhotoEditorError extends PhotoEditorState {
  final String message;

  const PhotoEditorError(this.message);

  @override
  List<Object?> get props => [message];
}
