import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract class HomeDataSourceInterface {
  Future<ResultApi<ProductResponseEntity>> getAllProducts();
  Future<ResultApi<List<CategoryItemEntity>>> getAllCategories();
}
