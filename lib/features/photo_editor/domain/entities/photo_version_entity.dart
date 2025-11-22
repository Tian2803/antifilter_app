import 'package:equatable/equatable.dart';

class PhotoVersionEntity extends Equatable {
  final String id;
  final String photoUrl;
  final String versionType; // 'original', 'no-filter', 'enhanced'
  final int processPercentage;

  const PhotoVersionEntity({
    required this.id,
    required this.photoUrl,
    required this.versionType,
    required this.processPercentage,
  });

  @override
  List<Object?> get props => [id, photoUrl, versionType, processPercentage];
}
