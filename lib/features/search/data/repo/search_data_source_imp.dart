import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/search/data/api/search_api_interface.dart';
import 'package:shopping_app/features/search/domain/repo/search_data_source_interface.dart';

@Injectable(as: SearchDataSourceInterface)
class SearchDataSourceImp implements SearchDataSourceInterface {
  final SearchApiInterface _api;
  SearchDataSourceImp(this._api);

  @override
  Future<ResultApi<ProductResponseEntity>> searchProducts(String query) async {
    final result = await _api.searchProducts(query);
    switch (result) {
      case Success<ProductResponseDto>():
        return Success(result.data.toEntity());
      case Error<ProductResponseDto>():
        return Error(result.messageError);
    }
  }
}
