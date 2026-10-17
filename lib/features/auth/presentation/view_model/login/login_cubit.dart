import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart';

part 'login_intent.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  final LoginUseCase _loginUseCase;

  Future<void> intent(LoginIntent intent) async {
    switch (intent) {
      case Login():
        await _login(intent.loginRequestEntity);
    }
  }

  Future<void> _login(LoginRequestEntity loginRequestEntity) async {
    emit(LoginLoading());
    final result = await _loginUseCase.invoke(loginRequestEntity);
    switch (result) {
      case Success():
        emit(LoginSuccess(result.data));
      case Error():
        emit(LoginError(result.messageError));
    }
  }
}
