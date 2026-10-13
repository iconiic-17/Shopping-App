import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/api/home_api_imp.dart'
    show token;
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:shopping_app/features/search/data/api/search_api_interface.dart';

@Injectable(as: SearchApiInterface)
class SearchApiImp implements SearchApiInterface {
  static const String _queryKey = 'search';

  @override
  Future<ResultApi<ProductResponseDto>> searchProducts(String query) async {
    try {
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.search}',
      );

      final http.Response response = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({_queryKey: query}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        return Success(ProductResponseDto.fromJson(json));
      } else {
        return Error('Result not found');
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
