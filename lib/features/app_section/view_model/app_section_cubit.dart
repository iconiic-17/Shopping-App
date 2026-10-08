import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_section_state.dart';

class AppSectionCubit extends Cubit<AppSectionState> {
  AppSectionCubit() : super(const AppSectionState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
