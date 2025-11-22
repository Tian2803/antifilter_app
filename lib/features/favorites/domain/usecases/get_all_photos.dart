import '../entities/favorite_photo_entity.dart';
import '../repositories/favorite_repository.dart';

class GetAllPhotosFav {
  final FavoriteRepository repository;

  GetAllPhotosFav(this.repository);

  Future<List<FavoritePhotoEntity>> call() async {
    return await repository.getAllPhotos();
  }
}
