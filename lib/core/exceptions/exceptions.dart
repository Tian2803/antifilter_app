abstract class AppException {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => message;
}

// EXCEPCIONES DE RED
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.originalError});
}

class NoInternetException extends NetworkException {
  const NoInternetException()
      : super(
          'Sin conexión a internet. Verifica tu conexión y vuelve a intentar.',
          code: 'NO_INTERNET',
        );
}

class NetworkUnreachableException extends NetworkException {
  const NetworkUnreachableException()
      : super(
          'Red inalcanzable. Verifica tu conexión o señal.',
          code: 'NETWORK_UNREACHABLE',
        );
}

class NoRouteToHostException extends NetworkException {
  const NoRouteToHostException()
      : super(
          'No hay ruta hacia el servidor. Revisa tu red o VPN.',
          code: 'NO_ROUTE_TO_HOST',
        );
}

class ConnectionFailedException extends NetworkException {
  const ConnectionFailedException()
      : super(
          'No se pudo establecer conexión con el servidor.',
          code: 'CONNECTION_FAILED',
        );
}

class BrokenPipeException extends NetworkException {
  const BrokenPipeException()
      : super(
          'Conexión interrumpida. Verifica tu red e intenta nuevamente.',
          code: 'BROKEN_PIPE',
        );
}

class FileUploadException extends NetworkException {
  const FileUploadException()
      : super(
          'Error al subir el archivo. El servidor interrumpió la conexión. '
          'Verifica que el archivo no sea demasiado grande e intenta nuevamente.',
          code: 'FILE_UPLOAD_ERROR',
        );
}

class ConnectionResetException extends NetworkException {
  const ConnectionResetException()
      : super('Conexión restablecida por el servidor.', code: 'CONNECTION_RESET');
}

class ServerUnavailableException extends NetworkException {
  const ServerUnavailableException()
      : super(
          'El servidor no está disponible en este momento.',
          code: 'SERVER_UNAVAILABLE',
        );
}

class RequestTimeoutException extends NetworkException {
  const RequestTimeoutException()
      : super(
          'La conexión tardó demasiado. Intenta nuevamente.',
          code: 'TIMEOUT',
        );
}

class HostLookupException extends NetworkException {
  const HostLookupException([String? host])
      : super(
          host != null
              ? 'Verifica tu DNS o conexión, $host no resuelto.'
              : 'Verifica tu DNS o conexión.',
          code: 'HOST_LOOKUP_FAILED',
        );
}

// EXCEPCIONES DE ARCHIVOS
class FileException extends AppException {
  const FileException(super.message, {super.code, super.originalError});
}

class FileNotExistsException extends FileException {
  const FileNotExistsException(String filePath)
      : super('El archivo no existe: $filePath', code: 'FILE_NOT_FOUND');
}

class FileTooLargeException extends FileException {
  const FileTooLargeException(String maxSize)
      : super(
          'El archivo es demasiado grande. Máximo permitido: $maxSize',
          code: 'FILE_TOO_LARGE',
        );
}

class InvalidFileFormatException extends FileException {
  const InvalidFileFormatException(String format)
      : super(
          'Formato de archivo no válido: $format',
          code: 'INVALID_FILE_FORMAT',
        );
}

// EXCEPCIONES DE DATOS / CACHÉ
class DataException extends AppException {
  const DataException(super.message, {super.code, super.originalError});
}

class ParseException extends DataException {
  const ParseException()
      : super('Error al procesar los datos recibidos.', code: 'PARSE_ERROR');
}

class CacheException extends DataException {
  const CacheException(String operation)
      : super('Error en caché durante: $operation', code: 'CACHE_ERROR');
}

// EXCEPCIONES DE AUTENTICACIÓN (Firebase)
class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.originalError});
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException()
      : super(
          'Este correo electrónico ya está registrado.',
          code: 'EMAIL_ALREADY_IN_USE',
        );
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException()
      : super(
          'El correo electrónico no es válido.',
          code: 'INVALID_EMAIL',
        );
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException()
      : super(
          'La contraseña es demasiado débil.',
          code: 'WEAK_PASSWORD',
        );
}

class WrongPasswordException extends AuthException {
  const WrongPasswordException()
      : super(
          'Contraseña incorrecta.',
          code: 'WRONG_PASSWORD',
        );
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException()
      : super(
          'No se encontró un usuario con este correo electrónico.',
          code: 'USER_NOT_FOUND',
        );
}

class UserDisabledException extends AuthException {
  const UserDisabledException()
      : super(
          'Esta cuenta ha sido deshabilitada.',
          code: 'USER_DISABLED',
        );
}

class TooManyAttemptsException extends AuthException {
  const TooManyAttemptsException()
      : super(
          'Demasiados intentos fallidos. Intenta más tarde.',
          code: 'TOO_MANY_ATTEMPTS',
        );
}

// EXCEPCIONES DE STORAGE (Firebase)
class StorageException extends AppException {
  const StorageException(super.message, {super.code, super.originalError});
}

class StorageQuotaExceededException extends StorageException {
  const StorageQuotaExceededException()
      : super(
          'Se ha excedido la cuota de almacenamiento.',
          code: 'QUOTA_EXCEEDED',
        );
}

class StorageUnauthorizedException extends StorageException {
  const StorageUnauthorizedException()
      : super(
          'No tienes permiso para realizar esta acción.',
          code: 'STORAGE_UNAUTHORIZED',
        );
}

// EXCEPCIONES GENERALES
class ServerException extends AppException {
  const ServerException(super.message, {super.code, super.originalError});
}
