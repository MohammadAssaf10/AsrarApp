import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/auth_preference.dart';
import '../../features/auth/data/data_sources/firebase_auth_helper.dart';
import '../../features/auth/data/data_sources/whatsapp_api.dart';
import '../../features/auth/data/repository/firebase_auth_repository.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/repository/home_repository.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';
import 'language.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared pref instance
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  instance
      .registerLazySingleton<FirebaseAuthHelper>(() => FirebaseAuthHelper());

  instance.registerLazySingleton<AuthPreference>(
      () => AuthPreference(instance<SharedPreferences>()));

  // language pref
  instance.registerLazySingleton(
      () => LanguageCacheHelper(instance<SharedPreferences>()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(instance<LanguageCacheHelper>()));
}

Future<void> initAuthenticationModule() async {
  if (!GetIt.I.isRegistered<AuthRepository>()) {
    final whatsAppApiConstants = WhatsAppApiConstance.instance;

    try {
      await whatsAppApiConstants.getWhatsAppApiConstants();
    } catch (e) {
      print(
          '\x1B[31m fuck from di failed to fetch whatsapp api stuff from firebase');
      print(
          '\x1B[31m fuck from di failed to fetch whatsapp api stuff from firebase');
    }

    Dio dio = await instance<DioFactory>().getDio();
    instance.registerLazySingleton<WhatsappApi>(
        () => WhatsappApi(dio, baseUrl: whatsAppApiConstants.baseUrl));

    instance.registerLazySingleton<AuthRepository>(() => registering(
        instance<FirebaseAuthHelper>(),
        instance<NetworkInfo>(),
        instance<WhatsappApi>(),
        instance<AuthPreference>()));
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeRepository>()) {
    instance.registerLazySingleton<HomeRepository>(() {
      return HomeRepositoryImpl(
        networkInfo: instance<NetworkInfo>(),
        firestore: FirebaseFirestore.instance,
      );
    });
  }
}
