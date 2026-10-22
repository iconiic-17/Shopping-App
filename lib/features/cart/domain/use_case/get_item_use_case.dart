import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/card_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';

@injectable
class GetCartUseCase {
  GetCartUseCase(this._repo);

  final CartRepoInterface _repo;

  Future<ResultApi<List<CartItemEntity>>> invoke() => _repo.getCart();
}

@injectable
class AddCartUseCase {
  AddCartUseCase(this._repo);

  final CartRepoInterface _repo;

  Future<ResultApi<void>> invoke(ProductWriteRequest product) =>
      _repo.addCart(product);
}

@injectable
class DeleteCartUseCase {
  DeleteCartUseCase(this._repo);

  final CartRepoInterface _repo;

  Future<ResultApi<void>> invoke(int productId) => _repo.deleteCart(productId);
}
