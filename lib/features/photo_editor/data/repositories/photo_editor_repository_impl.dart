import 'dart:io';
import '../../../../core/exceptions/exception_handler.dart';
import '../../domain/repositories/photo_editor_repository.dart';
import '../datasources/photo_editor_remote_data_source.dart';

class PhotoEditorRepositoryImpl implements PhotoEditorRepository {
  final PhotoEditorRemoteDataSource remoteDataSource;

  PhotoEditorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadPhoto(File imageFile) async {
    try {
      final photoId = await remoteDataSource.uploadPhoto(imageFile);
      return photoId;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  @override
  Future<String> saveToFavorites(File imageFile) async {
    try {
      final photoId = await remoteDataSource.saveToFavorites(imageFile);
      return photoId;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
