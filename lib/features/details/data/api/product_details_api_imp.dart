import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/helper/flutter_secure_storage.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/data/api/product_details_api_interface.dart';
import 'package:shopping_app/features/details/data/model/product_details_dto.dart';

@Injectable(as: ProductDetailsApiInterface)
class ProductDetailsApiImp implements ProductDetailsApiInterface {
  ProductDetailsApiImp(this._storage);

  final AppSecureStorage _storage;

  @override
  Future<ResultApi<ProductDetailsDto>> getProductDetails(int id) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllProduct}/$id',
      );

      final token = await _storage.read(AppKeys.token);

      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(ProductDetailsDto.fromJson(jsonDecode(response.body)));
      }
      return Error('Something went wrong (${response.statusCode})');
    } on TimeoutException {
      return Error('Request timed out, please try again');
    } on SocketException {
      return Error('No internet connection');
    } catch (e) {
      return Error(e.toString());
    }
  }
}
