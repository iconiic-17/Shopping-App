import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetProductsByCategoryUseCase {
  final HomeRepoInterface _repo;
  GetProductsByCategoryUseCase(this._repo);

  Future<ResultApi<ProductResponseEntity>> invoke(
    String slug, {
    int skip = 0,
    int limit = 10,
  }) async => await _repo.getProductsByCategory(slug, skip: skip, limit: limit);
}
