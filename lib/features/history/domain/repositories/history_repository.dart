import '../entities/history_photo_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryPhotoEntity>> getAllPhotos();
}
