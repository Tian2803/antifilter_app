import '../../domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel({
    required super.id,
    required super.userId,
    required super.originalUrl,
    super.processedUrl,
    required super.createdAt,
    super.isFavorite,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      originalUrl: json['originalUrl'] as String,
      processedUrl: json['processedUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'originalUrl': originalUrl,
      'processedUrl': processedUrl,
      'createdAt': createdAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }
}
