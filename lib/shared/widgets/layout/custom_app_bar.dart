/* import 'package:flutter/material.dart';
import 'package:mife_app/shared/themes/app_colors.dart';
import 'package:mife_app/shared/themes/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String route;
  final String? iconTitle;
  final String? imagePath;
  final IconData? icon;
  final IconData? iconBack;
  final bool? pop;
  final Color? backgroundColor;
  final Color? color;
  final Color? iconColor;
  final String? popRoute;

  const CustomAppBar({
    super.key,
    required this.title,
    this.iconTitle,
    required this.route,
    this.imagePath,
    this.icon,
    this.iconBack,
    this.pop = true,
    this.backgroundColor,
    this.color,
    this.iconColor,
    this.popRoute,
  });

  @override
  Size get preferredSize => const Size.fromHeight(95);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.mifeIvory,
      padding: const EdgeInsets.only(top: 30, left: 0, right: 7, bottom: 5),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (pop == false) {
                return; // No hacer nada si pop es false
              }

              // Si hay una ruta específica para pop, navegar a ella
              if (popRoute != null) {
                Navigator.pushReplacementNamed(context, popRoute!);
              } else {
                // Pop normal
                Navigator.pop(context);
              }
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.77,
              ),
              padding: const EdgeInsets.only(
                left: 10,
                right: 16,
                top: 4,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                color: color ?? AppColors.mifeLigthBlue,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconBack ?? Icons.arrow_back_ios_new_rounded,
                    size: 24,
                    color: AppColors.mifeText,
                    shadows: const [
                      Shadow(
                        offset: Offset(-1, 0),
                        blurRadius: 0,
                        color: AppColors.mifeText,
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: KTextStyle.styleAppBar,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (iconTitle != null) ...[
                    const SizedBox(width: 10),
                    Image.asset(
                      iconTitle.toString(),
                      height: 25,
                      width: 25,
                      color: iconColor ?? AppColors.mifeDarker,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const Spacer(),
          // Home IconButton
          IconButton(
            icon: icon != null
                ? Icon(icon, size: 36, color: AppColors.mifeCambridgeBlue)
                : Image.asset(
                    imagePath ?? 'assets/icons/home.png',
                    color: iconColor ?? AppColors.mifeCambridgeBlue,
                    height: 36,
                    width: 36,
                  ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(route);
            },
          ),
        ],
      ),
    );
  }
}
 */