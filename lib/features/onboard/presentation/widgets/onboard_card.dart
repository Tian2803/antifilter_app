import 'package:antifilter_app/features/onboard/domain/entities/onboard_item.dart';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardCard extends StatelessWidget {
  final OnboardItem item;

  const OnboardCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: item.color.withAlpha((255 * 0.1).toInt()),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, size: 100, color: item.color),
          ),
          const SizedBox(height: 48),
          Text(
            item.title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.white.withAlpha((255 * 0.7).toInt()),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
