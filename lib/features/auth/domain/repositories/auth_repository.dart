import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> initialize();
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get authStateChanges;
}
