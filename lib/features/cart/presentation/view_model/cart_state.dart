import 'package:shopping_app/features/cart/domain/entities/card_item_entity.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoading extends CartState {
  const CartLoading();
}

final class CartSuccess extends CartState {
  const CartSuccess(this.items, this.totalPrice);

  final List<CartItemEntity> items;
  final double totalPrice;
}

final class CartError extends CartState {
  const CartError(this.message);

  final String message;
}

final class CartActionSuccess extends CartState {
  const CartActionSuccess(this.message, this.items, this.totalPrice);

  final String message;
  final List<CartItemEntity> items;
  final double totalPrice;
}

final class CartActionError extends CartState {
  const CartActionError(this.message, this.items, this.totalPrice);

  final String message;
  final List<CartItemEntity> items;
  final double totalPrice;
}
