import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../config/app_localizations.dart';
import '../../config/routes_manager.dart';
import '../../config/theme_manager.dart';
import '../../features/auth/presentation/bloc/authentication_bloc.dart';
import '../../features/home/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import '../../features/home/presentation/blocs/course_bloc/course_bloc.dart';
import '../../features/home/presentation/blocs/job_bloc/job_bloc.dart';
import '../../features/home/presentation/blocs/news_bloc/news_bloc.dart';
import '../../features/home/presentation/blocs/service_order/service_order_bloc.dart';
import '../../features/home/presentation/blocs/services_bloc/services_bloc.dart';
import '../../features/home/presentation/blocs/subscription_bloc/subscription_bloc.dart';
import '../../features/home/presentation/blocs/terms_of_use_bloc/terms_of_use_bloc.dart';
import '../../features/home/presentation/blocs/user_bloc/user_bloc.dart';
import '../../features/shop/presentation/bloc/product_bloc/product_bloc.dart';
import '../../features/shop/presentation/bloc/shop_order_bloc/shop_order_bloc.dart';
import '../../language_cubit/language_cubit.dart';
import 'language.dart';
import '../../features/home/presentation/blocs/ad_image_bloc/ad_image_bloc.dart';
import '../../features/home/presentation/blocs/company_bloc/company_bloc.dart';

class MyApp extends StatelessWidget {
  // named constructor
  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CompanyBloc()..add(GetCompanyEvent())),
        BlocProvider(create: (context) => AdImageBloc()..add(GetAdImages())),
        BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()),
        BlocProvider<ServicesBloc>(create: (context) => ServicesBloc()),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
        BlocProvider<ShopOrderBloc>(create: (context) => ShopOrderBloc()),
        BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
        BlocProvider<CourseBloc>(create: (context) => CourseBloc()),
        BlocProvider<JobBloc>(create: (context) => JobBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<AboutUsBloc>(create: (context) => AboutUsBloc()),
        BlocProvider<TermsOfUseBloc>(create: (context) => TermsOfUseBloc()),
        BlocProvider<ServiceOrderBloc>(create: (context) => ServiceOrderBloc()),
        BlocProvider<SubscriptionBloc>(create: (context) => SubscriptionBloc()),
        BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: ((context) => AuthenticationBloc.instance..add(AppStarted())),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "أسرار",
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                supportedLocales: const [arabicLocale, englishLocale],
                locale: getLocal(),
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                theme: getApplicationTheme(),
                onGenerateRoute: RouteGenerator.getRoute,
              );
            },
          );
        },
      ),
    );
  }
}
