import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/helper/flutter_secure_storage.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AppSecureStorage storage) {
    final dio = Dio(
      BaseOptions(
        // Trailing slash + relative paths keeps `/api/v1` in the final URL.
        baseUrl: '${ApiConstants.baseUrl}/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(AppKeys.token);
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          final path = options.path;
          final isAbsolute =
              path.startsWith('http://') || path.startsWith('https://');
          if (!isAbsolute && path.startsWith('/')) {
            options.path = path.substring(1);
          }
          handler.next(options);
        },
      ),
    );
    return dio;
  }
}
