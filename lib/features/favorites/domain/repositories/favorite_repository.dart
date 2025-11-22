import '../entities/favorite_photo_entity.dart';

abstract class FavoriteRepository {
  Future<List<FavoritePhotoEntity>> getAllPhotos();
}
