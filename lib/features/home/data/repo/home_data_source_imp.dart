import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/api/home_api_interface.dart';
import 'package:shopping_app/features/home/data/model/categories_item_dto.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
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

  @override
  Future<ResultApi<List<CategoryItemEntity>>> getAllCategories() async {
    final result = await _api.getAllCategories();
    switch (result) {
      case Success<List<CategoryItemDto>>():
        return Success(result.data.map(((e) => e.toEntity())).toList());
      case Error<List<CategoryItemDto>>():
        return Error(result.messageError);
    }
  }

  @override
  Future<ResultApi<ProductResponseEntity>> getProductsByCategory(
    String slug, {
    int skip = 0,
    int limit = 10,
  }) async {
    final result = await _api.getProductsByCategory(
      slug,
      skip: skip,
      limit: limit,
    );
    switch (result) {
      case Success<ProductResponseDto>():
        return Success(result.data.toEntity());
      case Error<ProductResponseDto>():
        return Error(result.messageError);
    }
  }
}
