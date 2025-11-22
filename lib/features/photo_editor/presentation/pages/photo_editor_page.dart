import 'dart:io';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/photo_editor_bloc.dart';
import '../../../../core/di/injection_container.dart' as di;

class PhotoEditorPage extends StatelessWidget {
  final File imageFile;

  const PhotoEditorPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<PhotoEditorBloc>()..add(LoadPhotoEvent(imageFile)),
      child: const _PhotoEditorView(),
    );
  }
}

class _PhotoEditorView extends StatefulWidget {
  const _PhotoEditorView();

  @override
  State<_PhotoEditorView> createState() => _PhotoEditorViewState();
}

class _PhotoEditorViewState extends State<_PhotoEditorView> {
  bool _clearImage = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhotoEditorBloc, PhotoEditorState>(
        listener: (context, state) {
          if (state is PhotoUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is SavedToFavorites) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is PhotoEditorError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          File? currentImage;

          if (state is PhotoLoaded) {
            currentImage = state.imageFile;
          } else if (state is PhotoEditorLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final showImage = !_clearImage && currentImage != null;

          return Column(
            children: [
              // Imagen principal
              Expanded(
                child: Stack(
                  children: [
                    // Imagen grande
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withAlpha(
                              (255 * 0.1).toInt(),
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: showImage
                            ? Image.file(
                                currentImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    // Imagen pequeña superpuesta (antes/después)
                    Positioned(
                      left: 32,
                      bottom: 32,
                      child: Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withAlpha(
                                (255 * 0.2).toInt(),
                              ),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: showImage
                              ? Image.file(currentImage, fit: BoxFit.cover)
                              : Container(color: Colors.grey[300]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Botones de acción
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botón de eliminar
                    IconButton(
                      onPressed: _deletePhoto,
                      icon: const Icon(Icons.delete_outline, size: 30),
                      color: Colors.black,
                    ),
                    // Botón de quitar filtros (guarda en history)
                    CustomButton(
                      onTap: currentImage != null
                          ? () => _removeFilters(currentImage!)
                          : null,
                      text: 'photoEditor.removeFilters'.tr(),
                      width: 200,
                      height: 45,
                      borderRadius: 25,
                    ),
                    // Botón guardar en favoritos
                    IconButton(
                      onPressed: currentImage != null
                          ? () => _saveToFavorites(currentImage!)
                          : null,
                      icon: const Icon(Icons.bookmark_border, size: 30),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Botón de subir foto
              CustomButton(
                onTap: _pickNewImage,
                text: 'photoEditor.uploadPhoto'.tr(),
                width: 250,
                height: 45,
                borderRadius: 25,
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickNewImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null && mounted) {
      setState(() {
        _clearImage = false;
      });
      context.read<PhotoEditorBloc>().add(
        ChangePhotoEvent(File(pickedFile.path)),
      );
    }
  }

  void _removeFilters(File currentImage) {
    context.read<PhotoEditorBloc>().add(UploadPhotoEvent(currentImage));
  }

  void _deletePhoto() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        backgroundColor: AppColors.white,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Text(
            'photoEditor.clearTitle'.tr(),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: Text(
          'photoEditor.clearContent'.tr(),
          style: const TextStyle(
            fontSize: 17,
            color: AppColors.black,
            height: 1.3,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () {
                  Navigator.pop(dialogContext);
                  setState(() {
                    _clearImage = true;
                  });
                },
                text: 'photoEditor.clearConfirm'.tr(),
                backgroundColor: Colors.redAccent.shade200,
                height: 45,
                width: 130,
                borderRadius: 2,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onTap: () {
                  if (mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                },
                text: 'photoEditor.clearCancel'.tr(),
                backgroundColor: AppColors.pacificCyan,
                height: 45,
                width: 130,
                borderRadius: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveToFavorites(File currentImage) {
    context.read<PhotoEditorBloc>().add(SaveToFavoritesEvent(currentImage));
  }
}
