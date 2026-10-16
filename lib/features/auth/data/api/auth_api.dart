import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/model/register_request_dto.dart';

@injectable
class AuthApi {
  Future<ResultApi<String>> register(
    RegisterRequestDto request,
  ) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.register}');
      final response = await http.post(
        url,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final resBody = response.body;
        final json = jsonDecode(resBody);
        return Success(json['message']?.toString() ?? 'Registration successful');
      } else {
        try {
          final json = jsonDecode(response.body);
          return Error(json['message']?.toString() ?? 'Failed to register');
        } catch (_) {
          return Error('Failed to register (${response.statusCode})');
        }
      }
    } on SocketException {
      return Error('No Internet connection');
    } catch (e) {
      return Error('error from catch $e');
    }
  }
}
