import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/helper/flutter_secure_storage.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/model/login_request_dto.dart';
import 'package:shopping_app/features/auth/data/model/register_request_dto.dart';

@injectable
class AuthApi {
  AuthApi(this._storage);

  final AppSecureStorage _storage;

  static const _headers = {'Content-Type': 'application/json'};

  Future<ResultApi<String>> register(RegisterRequestDto request) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.register}');
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(_message(response.body) ?? 'Registered successfully');
      }
      return Error(_message(response.body) ?? 'Failed to register');
    } on SocketException {
      return Error('No Internet connection');
    } catch (e) {
      return Error('Error: $e');
    }
  }

  Future<ResultApi<String>> login(LoginRequestDto request) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final token = (json['token'] ?? json['data']?['token'])?.toString();

        if (token == null || token.isEmpty) {
          return Error('Login succeeded but no token was returned');
        }

        await _storage.write(AppKeys.token, token);
        return Success(json['message']?.toString() ?? 'Logged in successfully');
      }
      return Error(_message(response.body) ?? 'Invalid email or password');
    } on SocketException {
      return Error('No Internet connection');
    } catch (e) {
      return Error('Error: $e');
    }
  }

  String? _message(String body) {
    try {
      return jsonDecode(body)['message']?.toString();
    } catch (_) {
      return null;
    }
  }
}
