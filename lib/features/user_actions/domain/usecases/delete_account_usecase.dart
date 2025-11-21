import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/failures.dart';
import '../repositories/user_actions_repository.dart';

class DeleteAccountUseCase {
  final UserActionsRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.deleteAccount();
  }
}
