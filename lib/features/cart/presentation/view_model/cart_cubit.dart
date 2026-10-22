import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/card_item_entity.dart';
import 'package:shopping_app/features/cart/domain/use_case/get_item_use_case.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit(this._getCartUseCase, this._addCartUseCase, this._deleteCartUseCase)
    : super(const CartInitial());

  final GetCartUseCase _getCartUseCase;
  final AddCartUseCase _addCartUseCase;
  final DeleteCartUseCase _deleteCartUseCase;

  List<CartItemEntity> _items = [];

  List<CartItemEntity> get items => _items;

  double get totalPrice =>
      _items.fold<double>(0, (sum, item) => sum + item.lineTotal);

  bool isInCart(int productId) => _items.any((item) => item.id == productId);

  Future<void> getCart() async {
    if (state is CartInitial) {
      emit(const CartLoading());
    }
    final result = await _getCartUseCase.invoke();
    switch (result) {
      case Success<List<CartItemEntity>>():
        final localQty = {for (final i in _items) i.id: i.quantity};
        _items = result.data
            .map((i) => i.copyWith(quantity: localQty[i.id] ?? i.quantity))
            .toList();
        emit(CartSuccess(List.unmodifiable(_items), totalPrice));
      case Error<List<CartItemEntity>>():
        if (_items.isNotEmpty) {
          _emitAction(result.messageError, isError: true);
        } else {
          emit(CartError(result.messageError));
        }
    }
  }

  Future<void> addToCart(ProductItemEntity product) async {
    if (isInCart(product.id)) {
      changeQuantity(product.id, 1);
      _emitAction('Increased quantity in cart', isError: false);
      return;
    }

    final result = await _addCartUseCase.invoke(product.toWriteRequest());
    switch (result) {
      case Success<void>():
        _items = [
          ..._items,
          CartItemEntity(
            id: product.id,
            title: product.title,
            category: product.category,
            size: '',
            color: '',
            price: product.price,
            quantity: 1,
            image: product.primaryImage,
          ),
        ];
        _emitAction('Item added to cart successfully', isError: false);
      case Error<void>():
        _emitAction(result.messageError, isError: true);
    }
  }

  Future<void> deleteItem(int productId) async {
    final result = await _deleteCartUseCase.invoke(productId);
    switch (result) {
      case Success<void>():
        _items = _items.where((item) => item.id != productId).toList();
        _emitAction('Item removed from cart', isError: false);
      case Error<void>():
        _emitAction(result.messageError, isError: true);
    }
  }

  Future<void> clearCart() async {
    if (_items.isEmpty) return;
    final ids = _items.map((e) => e.id).toList();
    final results = await Future.wait(ids.map(_deleteCartUseCase.invoke));
    final hasError = results.any((r) => r is Error<void>);

    final refresh = await _getCartUseCase.invoke();
    if (refresh is Success<List<CartItemEntity>>) {
      _items = refresh.data;
    } else {
      _items = _items.where((item) {
        final idx = ids.indexOf(item.id);
        return idx != -1 && results[idx] is Error<void>;
      }).toList();
    }

    if (hasError) {
      _emitAction('Some items could not be removed', isError: true);
    } else {
      _items = [];
      _emitAction('Cart cleared', isError: false);
    }
  }

  void changeQuantity(int productId, int delta) {
    final index = _items.indexWhere((item) => item.id == productId);
    if (index == -1) return;
    final nextQuantity = _items[index].quantity + delta;
    if (nextQuantity <= 0) {
      deleteItem(productId);
      return;
    }
    _items[index] = _items[index].copyWith(quantity: nextQuantity);
    emit(CartSuccess(List.unmodifiable(_items), totalPrice));
  }

  void _emitAction(String message, {required bool isError}) {
    if (isError) {
      emit(CartActionError(message, List.unmodifiable(_items), totalPrice));
    } else {
      emit(CartActionSuccess(message, List.unmodifiable(_items), totalPrice));
      emit(CartSuccess(List.unmodifiable(_items), totalPrice));
    }
  }
}
