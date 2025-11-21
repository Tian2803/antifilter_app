import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bars, color: AppColors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          /* const SizedBox(width: 8),
          Image.asset("assets/logo.png", width: 150), */
        ],
      ),
    );
  }
}
