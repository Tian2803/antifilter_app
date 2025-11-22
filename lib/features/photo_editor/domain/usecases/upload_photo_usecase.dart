import 'dart:io';
import '../repositories/photo_editor_repository.dart';

class UploadPhotoUseCase {
  final PhotoEditorRepository repository;

  UploadPhotoUseCase(this.repository);

  Future<String> call(UploadPhotoParams params) async {
    return await repository.uploadPhoto(params.imageFile);
  }
}

class UploadPhotoParams {
  final File imageFile;

  UploadPhotoParams({required this.imageFile});
}
