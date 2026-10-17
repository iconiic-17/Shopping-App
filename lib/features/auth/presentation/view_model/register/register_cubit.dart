import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/domain/use_case/register_use_case.dart';

part 'register_intent.dart';
part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  final RegisterUseCase _registerUseCase;

  Future<void> intent(RegisterIntent intent) async {
    switch (intent) {
      case Register():
        await _register(intent.registerRequestEntity);
    }
  }

  Future<void> _register(RegisterRequestEntity registerRequestEntity) async {
    emit(RegisterLoading());
    final result = await _registerUseCase.invoke(registerRequestEntity);
    switch (result) {
      case Success<String>():
        emit(RegisterSuccess(result.data));
      case Error<String>():
        emit(RegisterError(result.messageError));
    }
  }
}

