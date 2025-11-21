import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/failures.dart';

abstract class UserActionsRepository {
  Future<Either<Failure, void>> deleteAccount();
}
