import '../entities/photo_entity.dart';

abstract class HomeRepository {
  Future<List<PhotoEntity>> getRecentPhotos(int limit);
}
