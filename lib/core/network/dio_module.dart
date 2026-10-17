import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/features/home/data/api/home_api_imp.dart'
    show token;

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        // Trailing slash + relative paths keeps `/api/v1` in the final URL.
        // A path like `/user/getCart` would otherwise resolve to
        // `https://host/user/getCart` and drop the API prefix.
        baseUrl: '${ApiConstants.baseUrl}/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $token';
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
