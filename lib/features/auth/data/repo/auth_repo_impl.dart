import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/helper/flutter_secure_storage.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImpl implements AuthRepoInterface {
  final AuthDataSourceInterface authDataSource;
  final AppSecureStorage storage;

  AuthRepoImpl(this.authDataSource, this.storage);

  @override
  Future<ResultApi<String>> register(RegisterRequestEntity register) async {
    return await authDataSource.register(register);
  }

  @override
  Future<ResultApi<String>> login(LoginRequestEntity login) async {
    final result = await authDataSource.login(login);

    switch (result) {
      case Success<String>():
        final token = result.data;
        await storage.write(AppKeys.token, token);
        return Success(token);

      case Error<String>():
        return Error(result.messageError);
    }
  }
}
