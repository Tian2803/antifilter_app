import '../../../../core/exceptions/exception_handler.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PhotoEntity>> getRecentPhotos(int limit) async {
    try {
      final photos = await remoteDataSource.getRecentPhotos(limit);
      return photos;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
