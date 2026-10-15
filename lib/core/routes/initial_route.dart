
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/routes/app_routes.dart';

Future<String> initialRoute() async {
  final storage = serviceLocator<AppSecureStorage>();
  final token = await storage.read(AppKeys.token);

  if (token.isNotEmpty) {
    return AppRoutes.register;
  } else {
    return AppRoutes.home;
  }
}
