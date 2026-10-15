import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';

@Injectable(as: CartRepoInterface)
class CartRepoImp implements CartRepoInterface {
  CartRepoImp(this._dataSource);

  final CartDataSourceInterface _dataSource;

  @override
  Future<ResultApi<List<CartItemEntity>>> getCart() => _dataSource.getCart();

  @override
  Future<ResultApi<void>> addCart(ProductWriteRequest product) =>
      _dataSource.addCart(product);

  @override
  Future<ResultApi<void>> deleteCart(int productId) =>
      _dataSource.deleteCart(productId);
}
