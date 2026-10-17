import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

@Injectable(as: FavouriteRepoInterface)
class FavouriteRepoImp implements FavouriteRepoInterface {
  FavouriteRepoImp(this._dataSource);

  final FavouriteDataSourceInterface _dataSource;

  @override
  Future<ResultApi<List<ProductItemEntity>>> getFavourites() =>
      _dataSource.getFavourites();

  @override
  Future<ResultApi<void>> addFavourite(ProductWriteRequest product) =>
      _dataSource.addFavourite(product);

  @override
  Future<ResultApi<void>> deleteFavourite(int productId) =>
      _dataSource.deleteFavourite(productId);
}
