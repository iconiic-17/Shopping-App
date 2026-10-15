import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

@injectable
class GetFavouritesUseCase {
  GetFavouritesUseCase(this._repo);

  final FavouriteRepoInterface _repo;

  Future<ResultApi<List<ProductItemEntity>>> invoke() => _repo.getFavourites();
}

@injectable
class AddFavouriteUseCase {
  AddFavouriteUseCase(this._repo);

  final FavouriteRepoInterface _repo;

  Future<ResultApi<void>> invoke(ProductWriteRequest product) =>
      _repo.addFavourite(product);
}

@injectable
class DeleteFavouriteUseCase {
  DeleteFavouriteUseCase(this._repo);

  final FavouriteRepoInterface _repo;

  Future<ResultApi<void>> invoke(int productId) =>
      _repo.deleteFavourite(productId);
}
