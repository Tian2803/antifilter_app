import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String id;
  final String userId;
  final String photoUrl;
  final DateTime createdAt;

  const PhotoEntity({
    required this.id,
    required this.userId,
    required this.photoUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, photoUrl, createdAt];
}
