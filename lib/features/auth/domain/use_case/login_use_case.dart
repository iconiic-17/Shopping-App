import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class LoginUseCase {
  final AuthRepoInterface _authRepo;

  LoginUseCase(this._authRepo);

  Future<ResultApi<String>> invoke(LoginRequestEntity login) async {
    return await _authRepo.login(login);
  }
}
