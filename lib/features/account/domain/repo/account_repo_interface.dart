import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/account_item_entity.dart';

abstract class AccountRepoInterface {
  Future<ResultApi<UserProfileEntity>> getUserProfile();
  Future<ResultApi<UserProfileEntity>> updateUserProfile(
    UpdateProfileParams params,
  );
  Future<ResultApi<String>> uploadProfileImage(String filePath);
}
