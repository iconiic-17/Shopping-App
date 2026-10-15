import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/data/model/product_details_dto.dart';

abstract interface class ProductDetailsApiInterface {
  Future<ResultApi<ProductDetailsDto>> getProductDetails(int id);
}
