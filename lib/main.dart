import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/di/service_locator.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_prefs.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  configureDependencies();

  final isFirstTime = await AppPrefs.isFirstTime();
  FlutterNativeSplash.remove();
  final  initialRoute=await initialRoute();
  runApp(MyApp(isFirstTime: isFirstTime,initialRoute: initialRoute,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstTime, required this.initialRoute});
  final String initialRoute;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: isFirstTime ? AppRoutes.onBoarding : initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
