 import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

class AuthRepoImpl  implements AuthRepoInterface{
  final AuthDataSourceInterface authDataSource;
  AuthRepoImpl(this.authDataSource);
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity register)async {
    return await authDataSource.register(register);
  }}