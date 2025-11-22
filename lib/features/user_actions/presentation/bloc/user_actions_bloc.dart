import 'package:bloc/bloc.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import 'user_actions_event.dart';
import 'user_actions_state.dart';

class UserActionsBloc extends Bloc<UserActionsEvent, UserActionsState> {
  final DeleteAccountUseCase deleteAccountUseCase;

  UserActionsBloc({required this.deleteAccountUseCase})
    : super(const UserActionsInitial()) {
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onDeleteAccount(
    DeleteAccountEvent event,
    Emitter<UserActionsState> emit,
  ) async {
    emit(const AccountDeleting());

    final result = await deleteAccountUseCase();

    result.fold(
      (failure) {
        emit(UserActionsError(failure.message));
      },
      (_) {
        emit(const AccountDeleted());
      },
    );
  }
}
