import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/data/model/card_item_dto.dart';
import 'package:shopping_app/features/cart/domain/entities/card_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';

@Injectable(as: CartDataSourceInterface)
class CartDataSourceImp implements CartDataSourceInterface {
  CartDataSourceImp(this._dio);

  final Dio _dio;

  @override
  Future<ResultApi<List<CartItemEntity>>> getCart() async {
    try {
      final response = await _dio.get(ApiConstants.getCart);
      return Success(_parseList(response.data));
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> addCart(ProductWriteRequest product) async {
    try {
      await _dio.post(ApiConstants.addCart, data: product.toJson());
      return Success(null);
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> deleteCart(int productId) async {
    try {
      await _dio.delete(
        ApiConstants.deleteCart,
        data: {'productId': productId, 'id': productId},
      );
      return Success(null);
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  List<CartItemEntity> _parseList(dynamic data) {
    final raw = extractApiList(
      data,
      keys: const ['list', 'products', 'cart', 'data', 'items'],
    );
    final items = <CartItemEntity>[];
    for (final item in raw) {
      if (item is Map) {
        items.add(
          CartItemDto.fromJson(Map<String, dynamic>.from(item)).toEntity(),
        );
      }
    }
    return items;
  }
}
