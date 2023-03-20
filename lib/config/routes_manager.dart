import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app/di.dart';
import '../features/auth/domain/entities/user.dart';
import '../features/auth/presentation/pages/auth_view.dart';
import '../features/auth/presentation/pages/password_reset_view.dart';
import '../features/auth/presentation/pages/verification_view.dart';
import '../features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import '../features/chat/presentation/pages/chat_screen.dart';
import '../features/home/domain/entities/company_entities.dart';
import '../features/home/domain/entities/course_entities.dart';
import '../features/home/domain/entities/job_entities.dart';
import '../features/home/domain/entities/news_entities.dart';
import '../features/home/domain/entities/service_entities.dart';
import '../features/home/domain/entities/service_order.dart';
import '../features/home/presentation/pages/course/course_details_screen.dart';
import '../features/home/presentation/pages/course/course_screen.dart';
import '../features/home/presentation/pages/job/job_details_screen.dart';
import '../features/home/presentation/pages/job/job_screen.dart';
import '../features/home/presentation/pages/main/main_view.dart';
import '../features/home/presentation/pages/main/notification_screen.dart';
import '../features/home/presentation/pages/main/subscription_screen.dart';
import '../features/home/presentation/pages/main/your_account.dart';
import '../features/home/presentation/pages/news/news_details_screen.dart';
import '../features/home/presentation/pages/news/news_screen.dart';
import '../features/home/presentation/pages/service&company/services_screen.dart';
import '../features/shop/domain/entities/product_entities.dart';
import '../features/shop/domain/entities/shop_order_entities.dart';
import '../features/shop/presentation/common/widgets/shop_order_details_view.dart';
import '../features/shop/presentation/pages/cart_screen.dart';
import '../features/home/presentation/pages/service&company/instructions_screen.dart';
import '../features/shop/presentation/pages/shop_screen.dart';
import '../splash.dart';
import 'strings_manager.dart';

class Routes {
  static const String splash = '/';

  // home route
  static const String homeRoute = "/home";
  static const String serviceRoute = "/service";
  static const String instructionsRoute = "/instructions";
  static const String shopRoute = "/shop";
  static const String cartRoute = "/cart";
  static const String newsRoute = "/news";
  static const String courseRoute = "/course";
  static const String newsDetailsRoute = "/newsDetails";
  static const String courseDetailsRoute = "/courseDetails";
  static const String shopOrderDetailsRoute = "/shopOrderDetails";
  static const String jobRoute = "/job";
  static const String jobDetailsRoute = "/jobDetails";
  static const String subscriptionRoute = "/subscription";
  static const String chatRoute = "/chat";
  static const String yourAccountRoute = "/yourAccount";
  static const String notificationRoute = "/notification";

  // auth rotes
  static const String auth = '/auth';
  static const String verificationView = '/verification';
  static const String passwordReset = '/passwordReset';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.shopRoute:
        return MaterialPageRoute(builder: (_) => const ShopScreen());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case Routes.cartRoute:
        {
          final arg = settings.arguments as List<ProductEntities>;
          return MaterialPageRoute(builder: (_) => CartScreen(arg));
        }
      case Routes.newsRoute:
        return MaterialPageRoute(builder: (_) => const NewsScreen());
      case Routes.courseRoute:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());

      case Routes.yourAccountRoute:
        {
          final arg = settings.arguments as User;
          return MaterialPageRoute(builder: (_) => YourAccountScreen(arg));
        }
      case Routes.jobRoute:
        return MaterialPageRoute(builder: (_) => const JobScreen());
      case Routes.subscriptionRoute:
        return MaterialPageRoute(builder: (_) => const SubscriptionScreen());
      case Routes.jobDetailsRoute:
        {
          final arg = settings.arguments as JobEntities;
          return MaterialPageRoute(
            builder: (context) => JobDetailsScreen(arg),
          );
        }
      case Routes.shopOrderDetailsRoute:
        {
          final arg = settings.arguments as ShopOrderEntities;
          return MaterialPageRoute(
            builder: (context) => ShopOrederDetailsView(arg),
          );
        }
      case Routes.courseDetailsRoute:
        {
          final arg = settings.arguments as CourseEntities;
          return MaterialPageRoute(
            builder: (context) => CourseDetailsScereen(arg),
          );
        }
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

      case Routes.chatRoute:
        {
          final arg = settings.arguments as ServiceOrder;
          print(arg);
          initChatModule(arg);
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ChatBloc()..add(ChatStarted(serviceOrder: arg)),
              lazy: false,
              child: ChatScreen(serviceOrder: arg),
            ),
          );
        }

      case Routes.instructionsRoute:
        {
          final arg = settings.arguments as ServiceEntities;
          return MaterialPageRoute(
            builder: (context) => InstructionsScreen(arg),
          );
        }
      case Routes.auth:
        return MaterialPageRoute(builder: (_) => const Auth());

      case Routes.verificationView:
        return MaterialPageRoute(builder: (_) => const VerificationView());

      case Routes.passwordReset:
        return MaterialPageRoute(builder: ((context) => PasswordResetView()));
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.noRouteFound.tr(context),
          ),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
