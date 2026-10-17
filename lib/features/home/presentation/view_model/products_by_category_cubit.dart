import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_products_by_category_use_case.dart';
import 'products_by_category_state.dart';

@injectable
class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  ProductsByCategoryCubit(this._useCase) : super(PBCInitial());

  final GetProductsByCategoryUseCase _useCase;

  Future<void> getProducts(String slug) async {
    emit(PBCLoading());
    final result = await _useCase.invoke(slug);
    if (isClosed) return;

    switch (result) {
      case Success<ProductResponseEntity>():
        final list = result.data.list;
        if (list.isEmpty) {
          emit(PBCEmpty());
        } else {
          emit(PBCSuccess(list));
        }
      case Error<ProductResponseEntity>():
        emit(PBCError(result.messageError));
    }
  }
}
