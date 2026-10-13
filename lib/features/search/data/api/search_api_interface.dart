import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';

abstract interface class SearchApiInterface {
  Future<ResultApi<ProductResponseDto>> searchProducts(String query);
}
