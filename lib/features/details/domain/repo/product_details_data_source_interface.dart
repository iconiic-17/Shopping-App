import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';

abstract interface class ProductDetailsDataSourceInterface {
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int id);
}
