import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class RegisterUseCase {
  final AuthRepoInterface _authRepo;

  RegisterUseCase(this._authRepo);

  Future<ResultApi<String>> invoke(RegisterRequestEntity register) async {
    return await _authRepo.register(register);
  }
}