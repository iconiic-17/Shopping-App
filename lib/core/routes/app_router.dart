import 'package:flutter/material.dart';

import 'package:shopping_app/features/app_section/view/app_section_view.dart';
import 'package:shopping_app/features/auth/presentation/screens/login_screen.dart';
import 'package:shopping_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:shopping_app/features/hello/presentation/screens/hello_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screen/onboarding_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.hello:
        return MaterialPageRoute(builder: (_) => const HelloScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const AppSectionView());
      default:
        debugPrint('Route not found: ${settings.name}');
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
        );
    }
  }
}
