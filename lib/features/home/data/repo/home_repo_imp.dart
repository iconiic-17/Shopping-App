import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@Injectable(as: HomeRepoInterface)
class HomeRepoImp implements HomeRepoInterface {
  final HomeDataSourceInterface _dataSource;
  HomeRepoImp(this._dataSource);

  @override
  Future<ResultApi<ProductResponseEntity>> getAllProducts() async =>
      await _dataSource.getAllProducts();

  @override
  Future<ResultApi<List<CategoryItemEntity>>> getAllCategories() async =>
      _dataSource.getAllCategories();

  @override
  Future<ResultApi<ProductResponseEntity>> getProductsByCategory(
    String slug, {
    int skip = 0,
    int limit = 10,
  }) async =>
      await _dataSource.getProductsByCategory(slug, skip: skip, limit: limit);
}
