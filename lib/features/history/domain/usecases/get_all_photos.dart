import '../entities/history_photo_entity.dart';
import '../repositories/history_repository.dart';

class GetAllPhotos {
  final HistoryRepository repository;

  GetAllPhotos(this.repository);

  Future<List<HistoryPhotoEntity>> call() async {
    return await repository.getAllPhotos();
  }
}
