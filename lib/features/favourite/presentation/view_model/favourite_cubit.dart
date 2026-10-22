import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/entities/favourit_item_entity.dart';
import 'package:shopping_app/features/favourite/domain/use_case/get_item_use_case.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

@lazySingleton
class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(
    this._getFavouritesUseCase,
    this._addFavouriteUseCase,
    this._deleteFavouriteUseCase,
  ) : super(const FavouriteInitial());

  final GetFavouritesUseCase _getFavouritesUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final DeleteFavouriteUseCase _deleteFavouriteUseCase;

  List<FavouriteItemEntity> _items = [];
  final Set<int> _favoriteIds = {};
  final Set<int> _busy = {};

  List<FavouriteItemEntity> get items => _items;

  bool isFavourite(int productId) => _favoriteIds.contains(productId);

  Future<void> getFavourites() async {
    if (state is FavouriteInitial) {
      emit(const FavouriteLoading());
    }
    final result = await _getFavouritesUseCase.invoke();
    switch (result) {
      case Success<List<FavouriteItemEntity>>(:final data):
        _items = List.from(data);
        _favoriteIds
          ..clear()
          ..addAll(_items.map((e) => e.id));
        emit(FavouriteSuccess(List.unmodifiable(_items)));
      case Error<List<FavouriteItemEntity>>(:final messageError):
        if (_items.isNotEmpty) {
          _emitAction(messageError, isError: true);
        } else {
          emit(FavouriteError(messageError));
        }
    }
  }

  Future<void> toggleFavourite(ProductItemEntity product) async {
    if (!_busy.add(product.id)) return;
    final wasFav = isFavourite(product.id);
    final favItem = FavouriteItemEntity.fromProduct(product);

    if (wasFav) {
      _favoriteIds.remove(product.id);
      _items = _items.where((item) => item.id != product.id).toList();
    } else {
      _favoriteIds.add(product.id);
      if (!_items.any((item) => item.id == product.id)) {
        _items = [..._items, favItem];
      }
    }
    emit(FavouriteSuccess(List.unmodifiable(_items)));

    try {
      final result = wasFav
          ? await _deleteFavouriteUseCase.invoke(product.id)
          : await _addFavouriteUseCase.invoke(product.toWriteRequest());

      switch (result) {
        case Success<void>():
          _emitAction(
            wasFav ? 'Removed from favourites' : 'Added to favourites',
            isError: false,
          );
        case Error<void>():
          if (wasFav) {
            _favoriteIds.add(product.id);
            if (!_items.any((item) => item.id == product.id)) {
              _items = [..._items, favItem];
            }
          } else {
            _favoriteIds.remove(product.id);
            _items = _items.where((item) => item.id != product.id).toList();
          }
          _emitAction(result.messageError, isError: true);
      }
    } finally {
      _busy.remove(product.id);
    }
  }

  Future<void> clearFavourites() async {
    if (_items.isEmpty) return;
    final ids = _items.map((e) => e.id).toList();
    final results = await Future.wait(ids.map(_deleteFavouriteUseCase.invoke));
    final hasError = results.any((r) => r is Error<void>);

    final refresh = await _getFavouritesUseCase.invoke();
    if (refresh is Success<List<FavouriteItemEntity>>) {
      _items = List.from(refresh.data);
      _favoriteIds
        ..clear()
        ..addAll(_items.map((e) => e.id));
    } else {
      _items = _items.where((item) {
        final idx = ids.indexOf(item.id);
        return idx != -1 && results[idx] is Error<void>;
      }).toList();
      _favoriteIds
        ..clear()
        ..addAll(_items.map((e) => e.id));
    }

    if (hasError) {
      _emitAction('Some items could not be removed', isError: true);
    } else {
      _items = [];
      _favoriteIds.clear();
      _emitAction('Wishlist cleared', isError: false);
    }
  }

  void _emitAction(String message, {required bool isError}) {
    if (isError) {
      emit(FavouriteActionError(message, List.unmodifiable(_items)));
    } else {
      emit(FavouriteActionSuccess(message, List.unmodifiable(_items)));
      emit(FavouriteSuccess(List.unmodifiable(_items)));
    }
  }
}
