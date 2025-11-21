import '../../../../core/exceptions/exception_handler.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> initialize() async {
    try {
      await remoteDataSource.initialize();
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      return user;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return user;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return remoteDataSource.authStateChanges;
  }
}
