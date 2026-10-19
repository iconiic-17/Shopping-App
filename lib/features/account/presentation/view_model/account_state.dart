import 'package:shopping_app/features/account/domain/entities/item_entity.dart';

abstract class AccountState {
  const AccountState({this.user});

  final UserProfileEntity? user;
}

class AccountInitial extends AccountState {
  const AccountInitial() : super(user: null);
}

class AccountLoading extends AccountState {
  const AccountLoading({super.user});
}

class AccountLoaded extends AccountState {
  const AccountLoaded(UserProfileEntity user) : super(user: user);
}

class AccountError extends AccountState {
  const AccountError(this.message, {super.user});

  final String message;
}

class AccountUpdateLoading extends AccountState {
  const AccountUpdateLoading({super.user});
}

class AccountUpdateSuccess extends AccountState {
  const AccountUpdateSuccess(
    UserProfileEntity user, {
    this.message = 'Profile updated successfully',
  }) : super(user: user);

  final String message;
}

class AccountUpdateError extends AccountState {
  const AccountUpdateError(this.message, {super.user});

  final String message;
}
