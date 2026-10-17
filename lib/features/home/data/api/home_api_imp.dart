import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/helper/flutter_secure_storage.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/api/home_api_interface.dart';
import 'package:shopping_app/features/home/data/model/categories_item_dto.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';

@Injectable(as: HomeApiInterface)
class HomeApiImp implements HomeApiInterface {
  HomeApiImp(this._storage);

  final AppSecureStorage _storage;

  Future<Map<String, String>> _headers() async {
    final token = await _storage.read(AppKeys.token);
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  void _logFailure(String name, http.Response response) {
    if (!kDebugMode) return;
    debugPrint('$name FAILED: ${response.statusCode}');
    debugPrint('$name BODY: ${response.body}');
  }

  @override
  Future<ResultApi<ProductResponseDto>> getProduct() async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllProduct}',
      );

      final response = await http
          .get(url, headers: await _headers())
          .timeout(const Duration(seconds: 60));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(ProductResponseDto.fromJson(jsonDecode(response.body)));
      }
      _logFailure('getProduct', response);
      return Error('Server error: ${response.statusCode}');
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<List<CategoryItemDto>>> getAllCategories() async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllCategories}',
      );

      final response = await http
          .get(url, headers: await _headers())
          .timeout(const Duration(seconds: 60));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        if (json['list'] != null) {
          final List jsonList = json['list'];
          return Success(
            jsonList.map((e) => CategoryItemDto.fromJson(e)).toList(),
          );
        }
        return Error('Error from json');
      }
      _logFailure('getAllCategories', response);
      return Error('Server error: ${response.statusCode}');
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<ProductResponseDto>> getProductsByCategory(
    String slug, {
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getProByCategory}/'
        '${Uri.encodeComponent(slug)}?skip=$skip&limit=$limit',
      );

      if (kDebugMode) debugPrint('URL => $url');

      final response = await http
          .get(url, headers: await _headers())
          .timeout(const Duration(seconds: 60));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(ProductResponseDto.fromJson(jsonDecode(response.body)));
      }
      _logFailure('getProductsByCategory', response);
      return Error('Server error: ${response.statusCode}');
    } catch (e) {
      return Error(e.toString());
    }
  }
}
