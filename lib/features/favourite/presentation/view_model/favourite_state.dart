import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  FavouriteSuccess(this.items);

  final List<ProductItemEntity> items;
}

class FavouriteError extends FavouriteState {
  FavouriteError(this.message);

  final String message;
}

class FavouriteActionSuccess extends FavouriteState {
  FavouriteActionSuccess(this.message, this.items);

  final String message;
  final List<ProductItemEntity> items;
}

class FavouriteActionError extends FavouriteState {
  FavouriteActionError(this.message, this.items);

  final String message;
  final List<ProductItemEntity> items;
}
