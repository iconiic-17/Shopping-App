import 'package:shopping_app/features/cart/domain/entities/item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  CartSuccess(this.items, this.totalPrice);

  final List<CartItemEntity> items;
  final double totalPrice;
}

class CartError extends CartState {
  CartError(this.message);

  final String message;
}

class CartActionSuccess extends CartState {
  CartActionSuccess(this.message, this.items, this.totalPrice);

  final String message;
  final List<CartItemEntity> items;
  final double totalPrice;
}

class CartActionError extends CartState {
  CartActionError(this.message, this.items, this.totalPrice);

  final String message;
  final List<CartItemEntity> items;
  final double totalPrice;
}
