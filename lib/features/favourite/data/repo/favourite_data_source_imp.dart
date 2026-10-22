import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/data/model/favourit_item_dto.dart';
import 'package:shopping_app/features/favourite/domain/entities/favourit_item_entity.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';

@Injectable(as: FavouriteDataSourceInterface)
class FavouriteDataSourceImp implements FavouriteDataSourceInterface {
  FavouriteDataSourceImp(this._dio);

  final Dio _dio;

  @override
  Future<ResultApi<List<FavouriteItemEntity>>> getFavourites() async {
    try {
      final response = await _dio.get(ApiConstants.getFavorite);
      return Success(_parseList(response.data));
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> addFavourite(ProductWriteRequest product) async {
    try {
      await _dio.post(ApiConstants.addToFavorite, data: product.toJson());
      return Success(null);
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> deleteFavourite(int productId) async {
    try {
      await _dio.delete(
        ApiConstants.removeFavorite,
        data: {'productId': productId, 'id': productId},
      );
      return Success(null);
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  List<FavouriteItemEntity> _parseList(dynamic data) {
    final raw = extractApiList(
      data,
      keys: const [
        'list',
        'favorites',
        'favourites',
        'products',
        'data',
        'items',
      ],
    );
    final items = <FavouriteItemEntity>[];
    for (final item in raw) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      items.add(FavouriteItemDto.fromJson(map).toEntity());
    }
    return items;
  }
}
