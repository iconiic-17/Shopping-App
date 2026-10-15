import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/item_entity.dart';
import 'package:shopping_app/features/cart/domain/use_case/get_item_use_case.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._getCartUseCase,
    this._addCartUseCase,
    this._deleteCartUseCase,
  ) : super(CartInitial());

  final GetCartUseCase _getCartUseCase;
  final AddCartUseCase _addCartUseCase;
  final DeleteCartUseCase _deleteCartUseCase;

  List<CartItemEntity> _items = [];

  List<CartItemEntity> get items => _items;

  double get totalPrice =>
      _items.fold<double>(0, (sum, item) => sum + item.lineTotal);

  bool isInCart(int productId) => _items.any((item) => item.id == productId);

  Future<void> getCart() async {
    if (_items.isEmpty) {
      emit(CartLoading());
    }
    final result = await _getCartUseCase.invoke();
    switch (result) {
      case Success<List<CartItemEntity>>():
        // Merge: keep locally-added items that the API doesn't know about yet.
        final apiIds = result.data.map((e) => e.id).toSet();
        final localOnly =
            _items.where((e) => !apiIds.contains(e.id)).toList();
        _items = [...result.data, ...localOnly];
        emit(CartSuccess(List.from(_items), totalPrice));
      case Error<List<CartItemEntity>>():
        // On error, keep whatever we already have locally.
        if (_items.isNotEmpty) {
          emit(CartSuccess(List.from(_items), totalPrice));
        } else {
          emit(CartError(result.messageError));
        }
    }
  }

  Future<void> addToCart(ProductItemEntity product) async {
    // Optimistic update: add locally first so the UI responds immediately.
    if (!isInCart(product.id)) {
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
    }
    _emitAction('Item added to cart successfully', isError: false);

    // Fire-and-forget: try the API in background; ignore server failures.
    _addCartUseCase.invoke(product.toWriteRequest());
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
    final ids = _items.map((e) => e.id).toList();
    for (final id in ids) {
      await _deleteCartUseCase.invoke(id);
    }
    _items = [];
    _emitAction('Cart cleared', isError: false);
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
    emit(CartSuccess(List.from(_items), totalPrice));
  }

  void _emitAction(String message, {required bool isError}) {
    if (isError) {
      emit(CartActionError(message, List.from(_items), totalPrice));
    } else {
      emit(CartActionSuccess(message, List.from(_items), totalPrice));
    }
    emit(CartSuccess(List.from(_items), totalPrice));
  }

  Future<void> _refreshQuietly() async {
    final result = await _getCartUseCase.invoke();
    if (result is Success<List<CartItemEntity>>) {
      _items = result.data;
    }
  }
}
