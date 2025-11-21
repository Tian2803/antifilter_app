import 'package:equatable/equatable.dart';

abstract class UserActionsEvent extends Equatable {
  const UserActionsEvent();

  @override
  List<Object?> get props => [];
}

class DeleteAccountEvent extends UserActionsEvent {
  const DeleteAccountEvent();
}
