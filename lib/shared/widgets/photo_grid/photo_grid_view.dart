import 'package:flutter/material.dart';
import 'photo_grid_card.dart';

class PhotoGridView extends StatelessWidget {
  final List<PhotoItem> photos;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final EdgeInsets? padding;
  final void Function(PhotoItem photo)? onPhotoTap;
  final bool enableDetailView;

  const PhotoGridView({
    super.key,
    required this.photos,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 12,
    this.mainAxisSpacing = 12,
    this.childAspectRatio = 0.75,
    this.padding,
    this.onPhotoTap,
    this.enableDetailView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return PhotoGridCard(
            photoUrl: photo.photoUrl,
            createdAt: photo.createdAt,
            onTap: enableDetailView
                ? () {
                    if (onPhotoTap != null) {
                      onPhotoTap!(photo);
                    }
                  }
                : null,
          );
        },
      ),
    );
  }
}

class PhotoItem {
  final String id;
  final String photoUrl;
  final DateTime createdAt;

  const PhotoItem({
    required this.id,
    required this.photoUrl,
    required this.createdAt,
  });
}
