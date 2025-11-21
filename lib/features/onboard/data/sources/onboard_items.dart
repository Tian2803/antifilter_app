import 'package:antifilter_app/features/onboard/domain/entities/onboard_item.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

final List<OnboardItem> onboardItems = [
    OnboardItem(
      title: 'onboard.slide1.title'.tr(),
      description: 'onboard.slide1.description'.tr(),
      icon: Icons.photo_filter,
      color: Colors.blue,
    ),
    OnboardItem(
      title: 'onboard.slide2.title'.tr(),
      description: 'onboard.slide2.description'.tr(),
      icon: Icons.high_quality,
      color: Colors.green,
    ),
    OnboardItem(
      title: 'onboard.slide3.title'.tr(),
      description: 'onboard.slide3.description'.tr(),
      icon: Icons.cloud_upload,
      color: Colors.orange,
    ),
  ];