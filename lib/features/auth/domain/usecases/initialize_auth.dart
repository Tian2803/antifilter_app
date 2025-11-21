import '../repositories/auth_repository.dart';

class InitializeAuth {
  final AuthRepository repository;

  InitializeAuth(this.repository);

  Future<void> call() async {
    return await repository.initialize();
  }
}
