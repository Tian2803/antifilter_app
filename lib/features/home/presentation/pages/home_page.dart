import 'dart:io';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/buttons/custom_button.dart';
import 'package:antifilter_app/shared/widgets/photo_grid/photo_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/di/injection_container.dart' as di;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = di.sl<HomeBloc>()..add(const LoadRecentPhotosEvent(limit: 3));
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null && mounted) {
      final imageFile = File(pickedFile.path);
      await context.push('/photo-editor', extra: imageFile);
      if (mounted) {
        _homeBloc.add(const LoadRecentPhotosEvent(limit: 3));
      }
    }
  }

  Widget _buildHistorialSection(HomeState state) {
    if (state is HomeLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
          strokeWidth: 10,
          strokeAlign: 1,
          backgroundColor: AppColors.pacificCyan,
        ),
      );
    }

    if (state is HomeEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'home.noPhotos'.tr(),
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
      );
    }

    if (state is PhotosLoaded) {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: Scaffold(
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner principal
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    onTap: _pickAndUploadImage,
                    text: 'home.uploadPhoto'.tr(),
                    width: 150,
                    borderRadius: 20,
                  ),
                ),
                const SizedBox(height: 20),
                // Sección Historial
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'home.historyTitle'.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomButton(
                        onTap: () => context.push('/history'),
                        text: 'home.seeMore'.tr(),
                        width: 65,
                        height: 25,
                        size: 12,
                        borderRadius: 3,
                      ),
                    ],
                  ),
                ),
                // Grid de historial
                SizedBox(
                  height: 170,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return _buildHistorialSection(state);
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
