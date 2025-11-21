import 'package:antifilter_app/core/exceptions/exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareUtils {

  static Future<void> shareToWhatsApp({
    required BuildContext context,
    String? message,
  }) async {
    final String defaultMessage = message ?? "🙏 Estoy usando Mi Fe - Una app increíble para fortalecer mi fe y crecimiento espiritual.\n\n📱 Descárgala en Google Play: https://play.google.com/store";
    final String whatsappUrl =
        "whatsapp://send?text=${Uri.encodeComponent(defaultMessage)}";

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        // Si WhatsApp no está instalado, abrir en el navegador web
        final String webUrl =
            "https://wa.me/?text=${Uri.encodeComponent(defaultMessage)}";
        await launchUrl(
          Uri.parse(webUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ExceptionHandler.handleError('No se pudo abrir WhatsApp');
      }
    }
  }

  static Future<void> openWhatsAppContact({
    required BuildContext context,
    required String phoneNumber,
    String? message,
  }) async {
    // Limpiar el número de teléfono (remover espacios, guiones, etc.)
    final String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final String encodedMessage = message != null ? Uri.encodeComponent(message) : '';
    
    // URL para abrir chat con número específico
    final String whatsappUrl = message != null 
        ? "whatsapp://send?phone=$cleanNumber&text=$encodedMessage"
        : "whatsapp://send?phone=$cleanNumber";

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        // Si WhatsApp no está instalado, abrir en el navegador web
        final String webUrl = message != null
            ? "https://wa.me/$cleanNumber?text=$encodedMessage"
            : "https://wa.me/$cleanNumber";
        await launchUrl(
          Uri.parse(webUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ExceptionHandler.handleError('No se pudo abrir WhatsApp');
      }
    }
  }
}