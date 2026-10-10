import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/api/home_api_interface.dart';
import 'package:shopping_app/features/home/data/model/product_item_dto.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';

@Injectable(as: HomeDataSourceInterface)
class HomeDataSourceImp implements HomeDataSourceInterface {
  final HomeApiInterface _api;
  HomeDataSourceImp(this._api);
  @override
  Future<ResultApi<ProductResponseEntity>> getAllProducts() async {
    final result = await _api.getProduct();
    switch (result) {
      case Success<ProductResponseDto>():
        return Success(result.data.toEntity());
      case Error<ProductResponseDto>():
        return Error(result.messageError);
    }
  }
}
