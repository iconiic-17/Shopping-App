import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract interface class HomeRepoInterface {
  Future<ResultApi<ProductResponseEntity>> getAllProducts();
}
