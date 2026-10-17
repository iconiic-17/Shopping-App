part of 'login_cubit.dart';

sealed class LoginIntent {}

class Login extends LoginIntent {
  final LoginRequestEntity loginRequestEntity;
  Login(this.loginRequestEntity);
}
