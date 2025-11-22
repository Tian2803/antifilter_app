import 'dart:io';

import '../repositories/photo_editor_repository.dart';

class SaveToFavoritesUseCase {
  final PhotoEditorRepository repository;

  SaveToFavoritesUseCase(this.repository);

  Future<String> call(File imageFile) async {
    return await repository.saveToFavorites(imageFile);
  }
}
