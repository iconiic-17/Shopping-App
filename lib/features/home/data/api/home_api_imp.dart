import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/api/home_api_interface.dart';
import 'package:shopping_app/features/home/data/model/product_item_dto.dart';
import 'package:http/http.dart' as http;

@Injectable(as: HomeApiInterface)
class HomeApiImp implements HomeApiInterface {
  @override
  Future<ResultApi<ProductResponseDto>> getProduct() async {
    try {
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllProduct}',
      );
      print('URL: $url');

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
      print('ERROR: $e');
      return Error(e.toString());
    }
  }
}

final String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhYzkwOTRmOTYxMDMwZmFjYmZlMTgyYSIsImlhdCI6MTc5MTU4NzU1NywiZXhwIjoxNzk0MTc5NTU3fQ.ykW5tyKjXMBktaKahvufcBKDAntFiVWnq5cO5B18Y3w";
