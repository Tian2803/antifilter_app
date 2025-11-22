import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/history_bloc.dart';
import '../../../../core/di/injection_container.dart' as di;
import '../../../../shared/widgets/photo_grid/photo_grid_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<HistoryBloc>()..add(const LoadAllPhotosEvent()),
      child: Scaffold(
        body: BlocListener<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state is HistoryError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                    strokeWidth: 15,
                    strokeAlign: 3,
                    backgroundColor: AppColors.pacificCyan,
                  ),
                );
              }

              if (state is HistoryEmpty) {
                return Center(
                  child: Text(
                    'history.noPhotos'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              if (state is HistoryPhotosLoaded) {
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
