import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';
import 'package:shopping_app/features/details/domain/use_case/get_product_details_use_case.dart';
import 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._useCase) : super(ProductDetailsLoading());

  final GetProductDetailsUseCase _useCase;

  Future<void> getDetails(int id) async {
    emit(ProductDetailsLoading());

    final result = await _useCase.invoke(id);
    if (isClosed) return;

    switch (result) {
      case Success<ProductDetailsEntity>():
        emit(ProductDetailsSuccess(result.data));
      case Error<ProductDetailsEntity>():
        emit(ProductDetailsError(result.messageError));
    }
  }
}
