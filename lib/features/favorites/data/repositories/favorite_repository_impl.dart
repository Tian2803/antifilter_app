import '../../../../core/exceptions/exception_handler.dart';
import '../../domain/entities/favorite_photo_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_remote_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<FavoritePhotoEntity>> getAllPhotos() async {
    try {
      final photos = await remoteDataSource.getAllPhotos();
      return photos;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
