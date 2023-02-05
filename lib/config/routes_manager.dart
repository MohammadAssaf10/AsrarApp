import 'package:flutter/material.dart';

import '../core/app/di.dart';
import '../features/auth/presentation/pages/auth_view.dart';
import '../features/auth/presentation/pages/password_reset_view.dart';
import '../features/auth/presentation/pages/verification_view.dart';
import '../features/home/domain/entities/company_entities.dart';
import '../features/home/domain/entities/news_entities.dart';
import '../features/home/domain/entities/service_entities.dart';
import '../features/home/presentation/pages/course/course_screen.dart';
import '../features/home/presentation/pages/main/main_view.dart';
import '../features/home/presentation/pages/news/news_details_screen.dart';
import '../features/home/presentation/pages/shop/cart_screen.dart';
import '../features/home/presentation/pages/news/news_screen.dart';
import '../features/home/presentation/pages/service&company/required_documents_screen.dart';
import '../features/home/presentation/pages/service&company/services_screen.dart';
import '../features/home/presentation/pages/shop/shop_screen.dart';
import '../splash.dart';
import 'strings_manager.dart';

class Routes {
  static const String splash = '/';

  // home route
  static const String homeRoute = "/home";
  static const String serviceRoute = "/service";
  static const String requiredDocumentsRoute = "/requiredDocuments";
  static const String shopRoute = "/shop";
  static const String cartRoute = "/cart";
  static const String newsRoute = "/news";
  static const String courseRoute = "/course";
  static const String newsDetailsRoute = "/newsDetails";

  // auth rotes
  static const String auth = '/auth';
  static const String verificationView = '/verification';
  static const String passwordReset = '/passwordReset';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.shopRoute:
        return MaterialPageRoute(builder: (_) => ShopScreen());
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case Routes.newsRoute:
        return MaterialPageRoute(builder: (_) => NewsScreen());
      case Routes.courseRoute:
        return MaterialPageRoute(builder: (_) => CoursesScreen());
      case Routes.newsDetailsRoute:
        {
          final arg = settings.arguments as NewsEntities;
          return MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(arg),
          );
        }
      case Routes.serviceRoute:
        {
          final arg = settings.arguments as CompanyEntities;
          return MaterialPageRoute(
            builder: (context) => ServicesScreen(arg),
          );
        }
      case Routes.requiredDocumentsRoute:
        {
          final arg = settings.arguments as ServiceEntities;
          return MaterialPageRoute(
            builder: (context) => RequiredDocumentsScreen(arg),
          );
        }
      case Routes.auth:
        return MaterialPageRoute(builder: (_) => Auth());

      case Routes.verificationView:
        return MaterialPageRoute(builder: (_) => VerificationView());

      case Routes.passwordReset:
        return MaterialPageRoute(builder: ((context) => PasswordResetView()));
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
