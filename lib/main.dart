import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping_app/core/widgets/app_snackbar.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';

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

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstTime});

  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<CartCubit>()),
        BlocProvider.value(value: serviceLocator<FavouriteCubit>()),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: isFirstTime ? AppRoutes.onBoarding : AppRoutes.hello,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<CartCubit, CartState>(
                listenWhen: (previous, current) =>
                    current is CartActionSuccess || current is CartActionError,
                listener: (context, state) {
                  if (state is CartActionSuccess) {
                    showAppSnackBar(context, message: state.message);
                  } else if (state is CartActionError) {
                    showAppSnackBar(
                      context,
                      message: state.message,
                      isError: true,
                    );
                  }
                },
              ),
              BlocListener<FavouriteCubit, FavouriteState>(
                listenWhen: (previous, current) =>
                    current is FavouriteActionSuccess ||
                    current is FavouriteActionError,
                listener: (context, state) {
                  if (state is FavouriteActionSuccess) {
                    showAppSnackBar(context, message: state.message);
                  } else if (state is FavouriteActionError) {
                    showAppSnackBar(
                      context,
                      message: state.message,
                      isError: true,
                    );
                  }
                },
              ),
            ],
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
