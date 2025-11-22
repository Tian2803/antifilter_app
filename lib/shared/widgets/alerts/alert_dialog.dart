// ignore_for_file: non_constant_identifier_names

import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

void showPersonalizedAlert(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 19,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.black,
      duration: const Duration(seconds: 3),
    ),
  );
}
