import 'package:shopping_app/features/favourite/domain/entities/favourit_item_entity.dart';

sealed class FavouriteState {
  const FavouriteState();
}

final class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();
}

final class FavouriteLoading extends FavouriteState {
  const FavouriteLoading();
}

final class FavouriteSuccess extends FavouriteState {
  const FavouriteSuccess(this.items);

  final List<FavouriteItemEntity> items;
}

final class FavouriteError extends FavouriteState {
  const FavouriteError(this.message);

  final String message;
}

final class FavouriteActionSuccess extends FavouriteState {
  const FavouriteActionSuccess(this.message, this.items);

  final String message;
  final List<FavouriteItemEntity> items;
}

final class FavouriteActionError extends FavouriteState {
  const FavouriteActionError(this.message, this.items);

  final String message;
  final List<FavouriteItemEntity> items;
}
