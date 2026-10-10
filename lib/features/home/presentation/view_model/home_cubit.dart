import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_categories_use_case.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_products_use_case.dart';

import 'home_state.dart';
part 'home_intent.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllProductsUseCase, this._allCategoriesUseCase)
    : super(HomeInitial());

  final GetAllProductsUseCase _getAllProductsUseCase;
  final GetAllCategoriesUseCase _allCategoriesUseCase;

  Future<void> intent(HomeIntent intent) async {
    switch (intent) {
      case HIProducts():
        await _getProducts();
      case HICProducts():
        await _getCategoryOfProducts();
      case HIntentCalls():
        await Future.wait([_getProducts(), _getCategoryOfProducts()]);
    }
  }

  Future<void> _getProducts() async {
    emit(HProductsLoading());
    final result = await _getAllProductsUseCase.invoke();

    switch (result) {
      case Success<ProductResponseEntity>():
        final listProduct = result.data.list;
        emit(HProductsSuccess(listProduct));
      case Error<ProductResponseEntity>():
        emit(HProductsError(result.messageError));
    }
  }

  Future<void> _getCategoryOfProducts() async {
    emit(CProductsLoading());
    final result = await _allCategoriesUseCase.invoke();
    switch (result) {
      case Success<List<CategoryItemEntity>>():
        emit(CProductsSuccess(result.data));
      case Error<List<CategoryItemEntity>>():
        emit(CProductsError(result.messageError));
    }
  }
}
