import '../../../../core/exceptions/exception_handler.dart';
import '../../domain/entities/history_photo_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HistoryPhotoEntity>> getAllPhotos() async {
    try {
      final photos = await remoteDataSource.getAllPhotos();
      return photos;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
