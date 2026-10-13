import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/search/domain/repo/search_repo_interface.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepoInterface _repo;
  SearchProductsUseCase(this._repo);

  Future<ResultApi<ProductResponseEntity>> invoke(String query) async =>
      await _repo.searchProducts(query);
}
