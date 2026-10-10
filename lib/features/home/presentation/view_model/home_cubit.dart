import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_products_use_case.dart';

import 'home_state.dart';
part 'home_intent.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllProductsUseCase) : super(HomeInitial());

  final GetAllProductsUseCase _getAllProductsUseCase;

  Future<void> intent(HomeIntent intent) async {
    switch (intent) {
      case HIProducts():
        await _getProducts();
    }
  }

  Future<void> _getProducts() async {
    print('CUBIT: _getProducts called');
    emit(HProductsLoading());
    final result = await _getAllProductsUseCase.invoke();
    print('CUBIT: result = $result');

    switch (result) {
      case Success<ProductResponseEntity>():
        final listProduct = result.data.list;
        print('PRODUCTS COUNT: ${listProduct.length}'); // 👈 الجديد
        emit(HProductsSuccess(listProduct));
      case Error<ProductResponseEntity>():
        emit(HProductsError(result.messageError));
    }
  }
}
