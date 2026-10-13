import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/model/categories_item_dto.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';

abstract interface class HomeApiInterface {
  Future<ResultApi<ProductResponseDto>> getProduct();
  Future<ResultApi<List<CategoryItemDto>>> getAllCategories();
  Future<ResultApi<ProductResponseDto>> getProductsByCategory(
    String slug, {
    int skip = 0,
    int limit = 5,
  });
}
