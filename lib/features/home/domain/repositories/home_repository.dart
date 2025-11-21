import '../entities/photo_entity.dart';

abstract class HomeRepository {
  Future<PhotoEntity> uploadPhoto(String filePath);
  Future<List<PhotoEntity>> getRecentPhotos(String userId);
}
