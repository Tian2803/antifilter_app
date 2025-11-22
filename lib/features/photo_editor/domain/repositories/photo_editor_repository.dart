import 'dart:io';

abstract class PhotoEditorRepository {
  Future<String> uploadPhoto(File imageFile);
  Future<String> saveToFavorites(File imageFile);
}
