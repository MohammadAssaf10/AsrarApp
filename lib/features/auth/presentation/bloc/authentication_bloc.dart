import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/di.dart' as di;
import '../../data/models/requests.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = di.instance<AuthRepository>();

  static AuthenticationBloc instance = AuthenticationBloc._();

  AuthenticationBloc._() : super(AuthenticationState(status: AuthStatus.init)) {
    // login
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      (await _authRepository.loginViaEmail(event.loginRequest)).fold((failure) {
        emit(state.copyWith(
            status: AuthStatus.failed, message: failure.message));
      }, (user) {
        emit(state.copyWith(
            status: AuthStatus.verificationCodeNeeded, user: user));
      });
    });

    // register
    on<RegisterButtonPressed>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      (await _authRepository.register(event.registerRequest)).fold((failure) {
        emit(state.copyWith(
            status: AuthStatus.failed, message: failure.message));
      }, (user) {
        emit(state.copyWith(
            status: AuthStatus.verificationCodeNeeded, user: user));
      });
    });

    on<ResetPasswordButtonPressed>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      (await _authRepository.resetPassword(event.email)).fold((failure) {
        emit(state.copyWith(
            status: AuthStatus.failed, message: failure.message));
      }, (_) {
        emit(state.copyWith(status: AuthStatus.resetPasswordSent));
      });
    });

    on<AppStarted>((event, emit) async {
      (await _authRepository.getCurrentUserIfExists()).fold(((l) {}), ((user) {
        if (user != null) {
          if (user.safeToContinue()) {
            emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
          }
        }
      }));
    });

    on<GoogleLoginButtonPressed>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStatus.loading));
        await (await _authRepository.loginViaGoogle()).fold(
          (failure) {
            emit(state.copyWith(
                status: AuthStatus.failed, message: failure.message));
          },
          (user) {
            if (user.phoneNumber.isEmpty) {
              emit(state.copyWith(
                  status: AuthStatus.phoneNumberNeeded, user: user));
            } else {
              emit(state.copyWith(
                  status: AuthStatus.verificationCodeNeeded, user: user));
            }
          },
        );
      },
    );

    on<MobileNumberEntered>((event, emit) async {
      var user = state.user;
      if (user == null) {
        emit(state.copyWith(status: AuthStatus.failed));
      } else {
        user = user.copyWith(phoneNumber: event.mobileNumber);

        emit(state.copyWith(
            status: AuthStatus.verificationCodeNeeded, user: user));
      }
    });

    on<LogOut>(
      (event, emit) async {
        var user = state.user;
        if (user != null) await _authRepository.logOut(user.email);
        emit(state.copyWith(status: AuthStatus.init));
      },
    );

    on<SendVerificationCode>(
      (event, emit) async {
        (await _authRepository.sendVerificationCode(event.number, event.code))
            .fold((failure) {
          emit(state.copyWith(
              status: AuthStatus.failed, message: failure.message));
        }, (r) {
          emit(state.copyWith(status: AuthStatus.verificationCodeNeeded));
        });
      },
    );

    on<VerificationCodeSubmitted>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStatus.loading));
        (await _authRepository.updateUserData(state.user!)).fold((l) {
          emit(state.copyWith(status: AuthStatus.failed, message: l.message));
        }, (r) {
          emit(state.copyWith(status: AuthStatus.loggedIn));
        });
      },
    );
  }
}
