import '../entities/photo_entity.dart';
import '../repositories/home_repository.dart';

class UploadPhoto {
  final HomeRepository repository;

  UploadPhoto(this.repository);

  Future<PhotoEntity> call(String filePath) async {
    return await repository.uploadPhoto(filePath);
  }
}
