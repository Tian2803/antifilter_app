import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'exceptions.dart';
import '../localStorage/local_storage_service.dart';

class ExceptionManager {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static Future<void> handleException(
    BuildContext context,
    AppException exception,
  ) async {
    _showErrorSnackBar(context, exception.message);

    if (exception is TokenExpiredException) {
      await _performLogout(context);
    }
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static Future<void> _performLogout(BuildContext context) async {
    try {
      await LocalStorageService.clearUserData();

      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
