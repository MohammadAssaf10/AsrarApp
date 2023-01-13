import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/di.dart';
import '../../data/data_sources/auth_prefs.dart';
import '../../data/models/requests.dart';
import '../../domain/repository/repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository _repository = instance<Repository>();
  final AuthPreferences _authPreferences = instance<AuthPreferences>();
  AuthenticationBloc() : super(AuthenticationInitial()) {

    // login
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _repository.login(event.loginRequest)).fold((failure) {
        emit(AuthenticationFailed(failure.message));
      }, (_) {
        emit(AuthenticationSuccess());
        _authPreferences.setUserLoggedIn();
      });
    });

    // register
    on<RegisterButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _repository.register(event.registerRequest)).fold((failure) {
        emit(AuthenticationFailed(failure.message));
      }, (_) {
        emit(AuthenticationSuccess());

        _authPreferences.setUserLoggedIn();
      });
    });

    on<SendVerificationCodeButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _repository.resetPassword(event.email)).fold((failure) {
        emit(AuthenticationFailed(failure.message));
      }, (_) {
        emit(ResetPasswordRequestSuccess());
      });
    });
  }
}
