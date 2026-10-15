import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/model/login_request_dto.dart';
import 'package:shopping_app/features/auth/data/model/register_request_dto.dart';

@injectable
class AuthApi {
  Future<ResultApi<String>> register(RegisterRequestDto request) async {
    try {
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.register}',
      );
      final response = await http.post(url, body: request.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        return Success(json['message'].toString());
      } else {
        return Error('Failed to register');
      }
    } on SocketException {
      return Error('No Internet connection');
    } catch (e) {
      return Error('Error: $e');
    }
  }

  Future<ResultApi<String>> login(LoginRequestDto request) async {
    try {
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.login}',
      );
      final response = await http.post(url, body: request.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        return Success(json['message'].toString());
      } else {
        return Error('Invalid email or password');
      }
    } on SocketException {
      return Error('No Internet connection');
    } catch (e) {
      return Error('Error: $e');
    }
  }
}
