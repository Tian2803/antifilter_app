import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/exceptions/exceptions.dart';

abstract class UserActionsRemoteDataSource {
  Future<void> deleteAccount();
}

class UserActionsRemoteDataSourceImpl implements UserActionsRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  UserActionsRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      log('Current user: ${user?.email}');
      
      if (user == null) {
        throw const AuthException('No hay usuario autenticado');
      }
      
      log('Attempting to delete user account...');
      await user.delete();
      log('User account deleted successfully');
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      if (e.code == 'requires-recent-login') {
        throw const AuthException(
          'Por seguridad, debes volver a iniciar sesión antes de eliminar tu cuenta',
        );
      }
      throw AuthException(e.message ?? 'Error al eliminar cuenta');
    } catch (e) {
      log('Unexpected error: $e');
      throw AuthException('Error inesperado: $e');
    }
  }
}
