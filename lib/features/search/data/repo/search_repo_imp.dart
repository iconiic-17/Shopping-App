import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/search/domain/repo/search_data_source_interface.dart';
import 'package:shopping_app/features/search/domain/repo/search_repo_interface.dart';

@Injectable(as: SearchRepoInterface)
class SearchRepoImp implements SearchRepoInterface {
  final SearchDataSourceInterface _dataSource;
  SearchRepoImp(this._dataSource);

  @override
  Future<ResultApi<ProductResponseEntity>> searchProducts(String query) async =>
      await _dataSource.searchProducts(query);
}
