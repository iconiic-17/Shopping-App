import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/data/api/product_details_api_interface.dart';
import 'package:shopping_app/features/details/data/model/product_details_dto.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';
import 'package:shopping_app/features/details/domain/repo/product_details_data_source_interface.dart';

@Injectable(as: ProductDetailsDataSourceInterface)
class ProductDetailsDataSourceImp implements ProductDetailsDataSourceInterface {
  final ProductDetailsApiInterface _api;
  ProductDetailsDataSourceImp(this._api);

  @override
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int id) async {
    final result = await _api.getProductDetails(id);
    switch (result) {
      case Success<ProductDetailsDto>():
        return Success(result.data.toEntity());
      case Error<ProductDetailsDto>():
        return Error(result.messageError);
    }
  }
}
