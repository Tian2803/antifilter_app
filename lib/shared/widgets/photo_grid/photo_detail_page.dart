import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/photo_grid/build_action_button.dart';
import 'package:antifilter_app/utils/format_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PhotoDetailPage extends StatelessWidget {
  final String photoUrl;
  final DateTime createdAt;

  const PhotoDetailPage({
    super.key,
    required this.photoUrl,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                photoUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Container(
                      width: 200,
                      height: 300,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 15,
                        strokeAlign: 3,
                        backgroundColor: AppColors.black,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.pacificCyan,
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'photoDetail.errorLoading'.tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColors.white,
                      size: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      FormatDate.formatDateDetail(createdAt),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildActionButton(
                      icon: Icons.download,
                      label: 'photoDetail.download'.tr(),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
