import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/item_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_data_source_interface.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@Injectable(as: AccountRepoInterface)
class AccountRepoImp implements AccountRepoInterface {
  AccountRepoImp(this._dataSource);

  final AccountDataSourceInterface _dataSource;

  @override
  Future<ResultApi<UserProfileEntity>> getUserProfile() =>
      _dataSource.getUserProfile();

  @override
  Future<ResultApi<UserProfileEntity>> updateUserProfile(
    UpdateProfileParams params,
  ) =>
      _dataSource.updateUserProfile(params);

  @override
  Future<ResultApi<String>> uploadProfileImage(String filePath) =>
      _dataSource.uploadProfileImage(filePath);
}
