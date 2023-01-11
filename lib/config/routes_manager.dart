import 'package:asrar_app/features/home/presentation/pages/main_view.dart';
import 'package:flutter/material.dart';

import '../core/app/di.dart';
import '../features/auth/presentation/pages/login/login_view.dart';
import '../features/auth/presentation/pages/register/register_view.dart';
import '../features/auth/presentation/pages/reset_password/reset_password_view.dart';
import 'strings_manager.dart';

class Routes {
  // home route
  static const String homeRoute = "/";

  // auth rotes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String resetPassword = '/resetPassword';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
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
      builder: (_) =>
          Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.noRouteFound,
              ),
            ),
            body: Center(
              child: Text(AppStrings.noRouteFound),
            ),
          ),
    );
  }
}
