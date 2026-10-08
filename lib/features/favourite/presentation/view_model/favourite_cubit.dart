import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
}
