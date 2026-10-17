import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract class FavouriteRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> getFavourites();
  Future<ResultApi<void>> addFavourite(ProductWriteRequest product);
  Future<ResultApi<void>> deleteFavourite(int productId);
}
