import 'dart:io';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'exceptions.dart';

class ExceptionHandler {
  static AppException handleError(dynamic error) {
    log('ExceptionHandler: ${error.toString()}');

    // Si es una AppException, retornarla directamente
    if (error is AppException) {
      return error;
    }

    // ERRORES DE FIREBASE AUTH
    if (error is firebase_auth.FirebaseAuthException) {
      return _handleFirebaseAuthError(error);
    }

    // ERRORES DE FIREBASE STORAGE
    if (error is firebase_storage.FirebaseException) {
      return _handleFirebaseStorageError(error);
    }

    // ERRORES DE CONEXIÓN (SocketException)
    if (error is SocketException) {
      final msg = error.message.toLowerCase();

      if (msg.contains('network is unreachable')) {
        return const NetworkUnreachableException();
      }

      if (msg.contains('no route to host')) {
        return const NoRouteToHostException();
      }

      if (msg.contains('connection failed')) {
        return const ConnectionFailedException();
      }

      if (msg.contains('broken pipe')) {
        return const BrokenPipeException();
      }

      if (msg.contains('connection reset by peer')) {
        return const ConnectionResetException();
      }

      if (msg.contains('connection refused')) {
        return const ServerUnavailableException();
      }

      if (msg.contains('connection timed out')) {
        return const RequestTimeoutException();
      }

      if (msg.contains('read failed')) {
        return const BrokenPipeException();
      }

      if (msg.contains('failed host lookup') ||
          msg.contains('host lookup failed') ||
          msg.contains('nodename nor servname provided')) {
        final hostMatch = RegExp(r"'([^']+)'").firstMatch(error.message);
        final host = hostMatch?.group(1);
        return HostLookupException(host);
      }

      return NetworkException(
        'Error de conexión desconocido: ${error.message}',
        code: 'UNKNOWN_NETWORK_ERROR',
      );
    }

    // TIMEOUT
    if (error.toString().toLowerCase().contains('timeout')) {
      return const RequestTimeoutException();
    }

    // CLIENTE HTTP
    if (error.toString().contains('ClientException')) {
      final errorStr = error.toString();

      if (errorStr.contains('SocketException')) {
        if (errorStr.contains('connection reset by peer')) {
          if (errorStr.contains('avatar') ||
              errorStr.contains('upload') ||
              errorStr.contains('multipart')) {
            return const FileUploadException();
          }
          return const ConnectionResetException();
        }
        if (errorStr.contains('read failed')) {
          return const BrokenPipeException();
        }
      }

      if (errorStr.toLowerCase().contains('connection reset')) {
        return const ConnectionResetException();
      }

      if (errorStr.contains('timeout')) {
        return const RequestTimeoutException();
      }

      return NetworkException(
        'Error del cliente HTTP: ${error.toString()}',
        code: 'CLIENT_EXCEPTION',
      );
    }

    // ERRORES DE FORMATO
    if (error is FormatException) {
      return const ParseException();
    }

    // FALLBACK GENERAL
    return DataException(
      'Error inesperado: ${error.toString()}',
      code: 'UNEXPECTED_ERROR',
    );
  }

  static AppException _handleFirebaseAuthError(
      firebase_auth.FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return const EmailAlreadyInUseException();
      case 'invalid-email':
        return const InvalidEmailException();
      case 'weak-password':
        return const WeakPasswordException();
      case 'wrong-password':
        return const WrongPasswordException();
      case 'user-not-found':
        return const UserNotFoundException();
      case 'user-disabled':
        return const UserDisabledException();
      case 'too-many-requests':
        return const TooManyAttemptsException();
      case 'operation-not-allowed':
        return AuthException(
          'Esta operación no está permitida.',
          code: error.code,
        );
      case 'account-exists-with-different-credential':
        return AuthException(
          'Ya existe una cuenta con un método de inicio de sesión diferente.',
          code: error.code,
        );
      default:
        return AuthException(
          error.message ?? 'Error de autenticación',
          code: error.code,
        );
    }
  }

  static AppException _handleFirebaseStorageError(
      firebase_storage.FirebaseException error) {
    switch (error.code) {
      case 'storage/unauthorized':
        return const StorageUnauthorizedException();
      case 'storage/quota-exceeded':
        return const StorageQuotaExceededException();
      case 'storage/object-not-found':
        return StorageException(
          'El archivo no existe.',
          code: error.code,
        );
      case 'storage/unauthenticated':
        return StorageException(
          'Debes iniciar sesión para realizar esta acción.',
          code: error.code,
        );
      default:
        return StorageException(
          error.message ?? 'Error de almacenamiento',
          code: error.code,
        );
    }
  }
}
