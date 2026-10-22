import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/entities/favourit_item_entity.dart';

abstract class FavouriteDataSourceInterface {
  Future<ResultApi<List<FavouriteItemEntity>>> getFavourites();
  Future<ResultApi<void>> addFavourite(ProductWriteRequest product);
  Future<ResultApi<void>> deleteFavourite(int productId);
}
