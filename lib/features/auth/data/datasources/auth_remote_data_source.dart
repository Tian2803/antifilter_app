import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> initialize();
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Future<void> initialize() async {
    try {
      await _googleSignIn.initialize();
      // Intentar autenticación ligera en segundo plano
      _googleSignIn.attemptLightweightAuthentication();
    } catch (e) {
      log('Google Sign In initialization: $e');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      // Verificar si la plataforma soporta authenticate
      if (!_googleSignIn.supportsAuthenticate()) {
        throw const AuthException(
          'Google Sign In no soporta autenticación en esta plataforma',
        );
      }

      // Disparar el flujo de autenticación
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      
      if (googleUser == null) {
        throw const AuthException('Inicio de sesión cancelado');
      }

      // Obtener los detalles de autenticación de la solicitud
      final googleAuth = await googleUser.authentication;

      // Crear una nueva credencial con el idToken
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión en Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        throw const AuthException('Error al iniciar sesión con Firebase');
      }

      return UserModel(
        id: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const AuthException('Inicio de sesión cancelado');
      }
      throw AuthException('Error de Google Sign In: ${e.description}');
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Error de autenticación');
    } catch (e) {
      throw AuthException('Error durante el inicio de sesión: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.disconnect(),
      ]);
    } catch (e) {
      throw const AuthException('Failed to sign out');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      return UserModel(
        id: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    } catch (e) {
      throw const AuthException('Failed to get current user');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(
        id: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    });
  }
}
