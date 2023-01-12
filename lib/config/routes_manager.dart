import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/auth_view.dart';
import '../features/home/presentation/pages/main_view.dart';
import '../splash.dart';
import 'strings_manager.dart';

class Routes {
  static const String splash = '/';

  // home route
  static const String homeRoute = "/home";

  // auth rotes
  static const String auth = '/auth';
  static const String resetPassword = '/resetPassword';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings){
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => MainView());

      case Routes.auth:
        return MaterialPageRoute(builder: (_) => Auth());

      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
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
