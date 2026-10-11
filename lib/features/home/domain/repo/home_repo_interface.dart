import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract interface class HomeRepoInterface {
  Future<ResultApi<ProductResponseEntity>> getAllProducts();
  Future<ResultApi<List<CategoryItemEntity>>> getAllCategories();
  Future<ResultApi<ProductResponseEntity>> getProductsByCategory(
    String slug, {
    int skip = 0,
    int limit = 5,
  });
}
