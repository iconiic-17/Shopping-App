import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/item_entity.dart';
import 'package:shopping_app/features/account/domain/use_case/get_item_use_case.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_state.dart';

@lazySingleton
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(
    this._getUserProfileUseCase,
    this._updateUserProfileUseCase,
    this._uploadProfileImageUseCase,
  ) : super(const AccountInitial());

  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  UserProfileEntity? get currentUser => state.user;

  Future<void> getProfile() async {
    emit(AccountLoading(user: state.user));
    final result = await _getUserProfileUseCase.invoke();
    if (result is Success<UserProfileEntity>) {
      emit(AccountLoaded(result.data));
    } else if (result is Error<UserProfileEntity>) {
      emit(AccountError(result.messageError, user: state.user));
    }
  }

  Future<bool> updateProfile(UpdateProfileParams params) async {
    final current = state.user;
    emit(AccountUpdateLoading(user: current));

    final result = await _updateUserProfileUseCase.invoke(params);

    if (result is Success<UserProfileEntity>) {
      emit(AccountUpdateSuccess(result.data));
      emit(AccountLoaded(result.data));
      return true;
    } else if (result is Error<UserProfileEntity>) {
      emit(AccountUpdateError(result.messageError, user: current));
      return false;
    }
    return false;
  }

  Future<String?> uploadProfileImage(String filePath) async {
    final result = await _uploadProfileImageUseCase.invoke(filePath);
    if (result is Success<String>) {
      return result.data;
    }
    return null;
  }
}
