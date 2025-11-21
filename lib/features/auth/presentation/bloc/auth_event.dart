part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class InitializeAuthEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final UserEntity? user;

  const AuthStateChangedEvent(this.user);

  @override
  List<Object> get props => [user ?? ''];
}
