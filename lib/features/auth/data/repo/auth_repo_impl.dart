import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImpl implements AuthRepoInterface {
  final AuthDataSourceInterface authDataSource;
 final FlutterSecureStorage storage;
  AuthRepoImpl(this.authDataSource,this.storage);

  @override
  Future<ResultApi<String>> register(RegisterRequestEntity register) async {
    return await authDataSource.register(register);
  }

  @override
 Future<ResultApi<String>> login(
    LoginRequestEntity login,
  ) async {
    final result = await authDataSource.login(login);

    switch (result) {
      case Success<LoginResponseEntity>():
        final entity = result.data;

        await storage.write(
          key: ApiConstants.token,
          value: entity.token,
        );

        return Success(entity.token);

      case Error<LoginResponseEntity>():
        return Error(result.messageError);
    }
  }
}
