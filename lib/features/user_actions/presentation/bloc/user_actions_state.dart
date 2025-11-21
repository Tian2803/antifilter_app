import 'package:equatable/equatable.dart';

abstract class UserActionsState extends Equatable {
  const UserActionsState();

  @override
  List<Object?> get props => [];
}

class UserActionsInitial extends UserActionsState {
  const UserActionsInitial();
}

class AccountDeleting extends UserActionsState {
  const AccountDeleting();
}

class AccountDeleted extends UserActionsState {
  const AccountDeleted();
}

class UserActionsError extends UserActionsState {
  final String message;

  const UserActionsError(this.message);

  @override
  List<Object?> get props => [message];
}
