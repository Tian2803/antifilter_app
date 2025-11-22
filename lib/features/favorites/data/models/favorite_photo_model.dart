import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/favorite_photo_entity.dart';

class FavoritePhotoModel extends FavoritePhotoEntity {
  const FavoritePhotoModel({
    required super.id,
    required super.userId,
    required super.photoUrl,
    required super.createdAt,
  });

  factory FavoritePhotoModel.fromJson(Map<String, dynamic> json) {
    DateTime createdAtDateTime;
    final createdAtValue = json['createdAt'];

    if (createdAtValue is Timestamp) {
      createdAtDateTime = createdAtValue.toDate();
    } else if (createdAtValue is String) {
      createdAtDateTime = DateTime.parse(createdAtValue);
    } else {
      createdAtDateTime = DateTime.now();
    }

    return FavoritePhotoModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: createdAtDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
