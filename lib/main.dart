import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/di/service_locator.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/initial_route.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_prefs.dart';
import 'features/cart/presentation/view_model/cart_cubit.dart';
import 'features/favourite/presentation/view_model/favourite_cubit.dart';
import 'features/account/presentation/view_model/account_cubit.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  configureDependencies();

  final isFirstTime = await AppPrefs.isFirstTime();
  final startRoute = await initialRoute();
  FlutterNativeSplash.remove();
  runApp(MyApp(isFirstTime: isFirstTime, initialRoute: startRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isFirstTime,
    required this.initialRoute,
  });

  final String initialRoute;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(create: (_) => serviceLocator<CartCubit>()),
        BlocProvider<FavouriteCubit>(
          create: (_) => serviceLocator<FavouriteCubit>(),
        ),
        BlocProvider<AccountCubit>(
          create: (_) => serviceLocator<AccountCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: isFirstTime ? AppRoutes.onBoarding : initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
