import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/model/product_item_dto.dart';

abstract class HomeApiInterface {
  Future<ResultApi<ProductResponseDto>> getProduct();
}
