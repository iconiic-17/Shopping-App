import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/card_item_entity.dart';

abstract class CartRepoInterface {
  Future<ResultApi<List<CartItemEntity>>> getCart();
  Future<ResultApi<void>> addCart(ProductWriteRequest product);
  Future<ResultApi<void>> deleteCart(int productId);
}
