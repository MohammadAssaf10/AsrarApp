import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/login/login_view.dart';
import '../features/auth/presentation/pages/register/register_view.dart';
import '../features/auth/presentation/pages/reset_password/reset_password_view.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = '/';

  // auth rotes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String resetPassword = '/resetPassword';

  static const String mainRoute = '/home';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
