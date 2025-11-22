import '../entities/photo_entity.dart';
import '../repositories/home_repository.dart';

class GetRecentPhotos {
  final HomeRepository repository;

  GetRecentPhotos(this.repository);

  Future<List<PhotoEntity>> call(int limit) async {
    return await repository.getRecentPhotos(limit);
  }
}
