import '../../../../core/exceptions/exception_handler.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<PhotoEntity> uploadPhoto(String filePath) async {
    try {
      // TODO: Get userId from auth
      final photo = await remoteDataSource.uploadPhoto(filePath, 'temp-user-id');
      return photo;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  @override
  Future<List<PhotoEntity>> getRecentPhotos(String userId) async {
    try {
      final photos = await remoteDataSource.getRecentPhotos(userId);
      return photos;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
