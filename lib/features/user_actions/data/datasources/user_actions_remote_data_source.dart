import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
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
        throw AuthException('userActions.notAuthenticated'.tr());
      }

      await user.delete();
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      if (e.code == 'requires-recent-login') {
        throw AuthException('userActions.recentLoginRequired'.tr());
      }
      throw AuthException(e.message ?? 'userActions.errorDeletingAccount'.tr());
    } catch (e) {
      throw AuthException(
        'userActions.unexpectedError'.tr(args: [e.toString()]),
      );
    }
  }
}
