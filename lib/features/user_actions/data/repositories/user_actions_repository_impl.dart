import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/exceptions/failures.dart';
import '../../domain/repositories/user_actions_repository.dart';
import '../datasources/user_actions_remote_data_source.dart';

class UserActionsRepositoryImpl implements UserActionsRepository {
  final UserActionsRemoteDataSource remoteDataSource;

  UserActionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
