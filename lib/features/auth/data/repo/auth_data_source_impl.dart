import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/api/auth_api.dart';
import 'package:shopping_app/features/auth/data/model/login_request_dto.dart';
import 'package:shopping_app/features/auth/data/model/register_request_dto.dart';
import 'package:shopping_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';

@Injectable(as: AuthDataSourceInterface)
class AuthDataSourceImpl implements AuthDataSourceInterface {
  final AuthApi authApi;

  AuthDataSourceImpl(this.authApi);

  @override
  Future<ResultApi<String>> register(RegisterRequestEntity register) {
    final dto = RegisterRequestDto(
      email: register.email,
      password: register.password,
      name: register.name,
      phone: register.phone,
      confirmPassword: register.confirmPassword,
    );
    return authApi.register(dto);
  }

  @override
  Future<ResultApi<String>> login(LoginRequestEntity login) {
    final dto = LoginRequestDto(
      email: login.email,
      password: login.password,
    );
    return authApi.login(dto);
  }
}