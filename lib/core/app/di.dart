import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/firebase.dart';
import '../../features/auth/data/repository/repository_impl.dart';
import '../../features/auth/domain/repository/repository.dart';
import '../../features/home/data/repositories/file_repository_impl.dart';
import '../../features/home/domain/repositories/file_repository.dart';
import '../../features/home/domain/use_cases/get_companies.dart';
import '../../features/home/domain/use_cases/get_file.dart';
import '../network/network_info.dart';

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
}

void initAuthenticationModule() {
  if (!GetIt.I.isRegistered<AuthRepository>()) {
    instance.registerLazySingleton<AuthRepository>(
        () => FirebaseAuthRepository(instance(), instance()));
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<FileRepository>()) {
    instance.registerLazySingleton<FileRepository>(() => FileRepositoryImpl(
        storage: FirebaseStorage.instance,
        networkInfo: instance<NetworkInfo>()));
    instance.registerLazySingleton<GetFileUseCase>(
        () => GetFileUseCase(instance<FileRepository>()));
    instance
        .registerLazySingleton<GetCompaniesUseCase>(() => GetCompaniesUseCase());
  }
}
