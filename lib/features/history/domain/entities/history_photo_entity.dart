import 'package:equatable/equatable.dart';

class HistoryPhotoEntity extends Equatable {
  final String id;
  final String userId;
  final String photoUrl;
  final DateTime createdAt;

  const HistoryPhotoEntity({
    required this.id,
    required this.userId,
    required this.photoUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, photoUrl, createdAt];
}
