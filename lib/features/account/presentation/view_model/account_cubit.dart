import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
}
