import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';

abstract interface class AuthDataSourceInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity register);

}