import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/item_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@injectable
class GetUserProfileUseCase {
  GetUserProfileUseCase(this._repo);

  final AccountRepoInterface _repo;

  Future<ResultApi<UserProfileEntity>> invoke() => _repo.getUserProfile();
}

@injectable
class UpdateUserProfileUseCase {
  UpdateUserProfileUseCase(this._repo);

  final AccountRepoInterface _repo;

  Future<ResultApi<UserProfileEntity>> invoke(UpdateProfileParams params) =>
      _repo.updateUserProfile(params);
}

@injectable
class UploadProfileImageUseCase {
  UploadProfileImageUseCase(this._repo);

  final AccountRepoInterface _repo;

  Future<ResultApi<String>> invoke(String filePath) =>
      _repo.uploadProfileImage(filePath);
}
