import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/di.dart' as di;
import '../../data/models/requests.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = di.instance<AuthRepository>();

  static AuthenticationBloc instance = AuthenticationBloc._();

  AuthenticationBloc._() : super(AuthenticationInitial()) {
    // login
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _authRepository.login(event.loginRequest)).fold((failure) {
        emit(AuthenticationFailed(failure.message));
      }, (user) {
        emit(AuthenticationSuccess(user: user));
      });
    });

    // register
    on<RegisterButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _authRepository.register(event.registerRequest)).fold((failure) {
        emit(AuthenticationFailed(failure.message));
      }, (user) {
        emit(AuthenticationSuccess(user: user));

      });
    });

    on<SendVerificationCodeButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _authRepository.resetPassword(event.email)).fold((failure) {
        emit(AuthenticationFailed(failure.message));
      }, (_) {
        emit(ResetPasswordRequestSuccess());
      });
    });

    on<AppStarted>((event, emit) async {
      (await _authRepository.getCurrentUserIfExists()).fold(((l) {}), ((user) {
        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        }
      }));
    });
  }
}
