import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap; // Cambiar a nullable
  final Color? textColor;
  final Color? backgroundColor;
  final double? size;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? elevation;
  final bool isEnabled; // Nuevo parámetro

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.size,
    this.fontWeight,
    this.height,
    this.width,
    this.borderRadius,
    this.elevation,
    this.isEnabled = true, // Por defecto habilitado
  });

  @override
  Widget build(BuildContext context) {
    // Determinar colores basados en si está habilitado
    Color finalBackgroundColor = backgroundColor ?? AppColors.black;
    Color finalTextColor = textColor ?? AppColors.white;

    if (!isEnabled) {
      finalBackgroundColor = (backgroundColor ?? AppColors.black).withAlpha((0.3 * 255).toInt());
      finalTextColor = (textColor ?? AppColors.white).withAlpha((0.5 * 255).toInt());
    }

    return Material(
      elevation: isEnabled ? (elevation ?? 1.0) : 0.0, // Sin sombra si está deshabilitado
      shadowColor: AppColors.black,
      borderRadius: BorderRadius.circular(borderRadius ?? 15),
      color: finalBackgroundColor,
      child: InkWell(
        onTap: isEnabled ? onTap : null, // Solo ejecutar si está habilitado
        borderRadius: BorderRadius.circular(borderRadius ?? 15),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width * 0.9,
          height: height ?? 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 15),
            color: finalBackgroundColor,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: size ?? 18,
                fontWeight: fontWeight ?? FontWeight.w600,
                color: finalTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
