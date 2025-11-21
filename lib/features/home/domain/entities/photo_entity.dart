import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String id;
  final String userId;
  final String originalUrl;
  final String? processedUrl;
  final DateTime createdAt;
  final bool isFavorite;

  const PhotoEntity({
    required this.id,
    required this.userId,
    required this.originalUrl,
    this.processedUrl,
    required this.createdAt,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        originalUrl,
        processedUrl,
        createdAt,
        isFavorite,
      ];
}
