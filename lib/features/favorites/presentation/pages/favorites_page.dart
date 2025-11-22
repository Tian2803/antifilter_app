import 'package:antifilter_app/core/di/injection_container.dart' as di;
import 'package:antifilter_app/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/photo_grid/photo_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<FavoriteBloc>()..add(const LoadAllPhotosEvent()),
      child: Scaffold(
        body: BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                    strokeWidth: 15,
                    strokeAlign: 3,
                    backgroundColor: AppColors.pacificCyan,
                  ),
                );
              }

              if (state is FavoriteEmpty) {
                return Center(
                  child: Text(
                    'favorites.noPhotos'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              if (state is FavoritePhotosLoaded) {
                final photoItems = state.photos.map((photo) {
                  return PhotoItem(
                    id: photo.id,
                    photoUrl: photo.photoUrl,
                    createdAt: photo.createdAt,
                  );
                }).toList();

                return PhotoGridView(
                  photos: photoItems,
                  enableDetailView: false,
                  onPhotoTap: (photo) {
                    context.push(
                      '/photo-detail',
                      extra: {
                        'photoUrl': photo.photoUrl,
                        'createdAt': photo.createdAt,
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
