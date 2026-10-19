import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/use_case/get_item_use_case.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

@lazySingleton
class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(
    this._getFavouritesUseCase,
    this._addFavouriteUseCase,
    this._deleteFavouriteUseCase,
  ) : super(FavouriteInitial());

  final GetFavouritesUseCase _getFavouritesUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final DeleteFavouriteUseCase _deleteFavouriteUseCase;

  List<ProductItemEntity> _items = [];
  final Set<int> _favoriteIds = {};

  List<ProductItemEntity> get items => _items;

  bool isFavourite(int productId) => _favoriteIds.contains(productId);

  Future<void> getFavourites() async {
    if (_items.isEmpty) {
      emit(FavouriteLoading());
    }
    final result = await _getFavouritesUseCase.invoke();
    switch (result) {
      case Success<List<ProductItemEntity>>():
        _items = result.data;
        _favoriteIds
          ..clear()
          ..addAll(_items.map((e) => e.id));
        emit(FavouriteSuccess(List.from(_items)));
      case Error<List<ProductItemEntity>>():
        emit(FavouriteError(result.messageError));
    }
  }

  Future<void> toggleFavourite(ProductItemEntity product) async {
    final alreadyFavourite = isFavourite(product.id);

    final result = alreadyFavourite
        ? await _deleteFavouriteUseCase.invoke(product.id)
        : await _addFavouriteUseCase.invoke(product.toWriteRequest());

    switch (result) {
      case Success<void>():
        if (alreadyFavourite) {
          _favoriteIds.remove(product.id);
          _items = _items.where((item) => item.id != product.id).toList();
          _emitAction('Removed from favourites', isError: false);
        } else {
          _favoriteIds.add(product.id);
          if (!_items.any((item) => item.id == product.id)) {
            _items = [..._items, product];
          }
          _emitAction('Added to favourites', isError: false);
        }
      case Error<void>():
        _emitAction(result.messageError, isError: true);
    }
  }

  Future<void> clearFavourites() async {
    final ids = _items.map((e) => e.id).toList();
    for (final id in ids) {
      await _deleteFavouriteUseCase.invoke(id);
    }
    _items = [];
    _favoriteIds.clear();
    _emitAction('Wishlist cleared', isError: false);
  }

  void _emitAction(String message, {required bool isError}) {
    if (isError) {
      emit(FavouriteActionError(message, List.from(_items)));
    } else {
      emit(FavouriteActionSuccess(message, List.from(_items)));
      emit(FavouriteSuccess(List.from(_items)));
    }
  }
}
