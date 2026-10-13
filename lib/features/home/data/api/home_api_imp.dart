import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/api/home_api_interface.dart';
import 'package:shopping_app/features/home/data/model/categories_item_dto.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:http/http.dart' as http;

@Injectable(as: HomeApiInterface)
class HomeApiImp implements HomeApiInterface {
  @override
  Future<ResultApi<ProductResponseDto>> getProduct() async {
    try {
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllProduct}',
      );

      final http.Response response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        return Success(ProductResponseDto.fromJson(json));
      } else {
        return Error('Server error: ${response.statusCode}');
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<List<CategoryItemDto>>> getAllCategories() async {
    try {
      var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllCategories}',
      );
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (json['list'] != null) {
          List jsonList = json['list'];
          var listOfCategory = jsonList
              .map((e) => CategoryItemDto.fromJson(e))
              .toList();
          return Success(listOfCategory);
        } else {
          return Error("Error from json");
        }
      } else {
        return Error("Server error: ${response.statusCode}");
      }
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
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getProByCategory}/'
        '${Uri.encodeComponent(slug)}?skip=$skip&limit=$limit',
      );

      print('URL => $url');

      final http.Response response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        return Success(ProductResponseDto.fromJson(json));
      } else {
        return Error('Server error: ${response.statusCode}');
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}

final String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhY2I4NzRhZWY4MTdjMmM3MmE5ODhjNyIsImlhdCI6MTc5MTcyMzM2NywiZXhwIjoxNzk0MzE1MzY3fQ.N_8PWCi5Sq52pb7qh0T5I_2Q4nc9HGgzFoKSBX7qvAU";
