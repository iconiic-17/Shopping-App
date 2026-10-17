part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess(this.message);
}

final class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}
