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

  AuthenticationBloc._() : super(AuthenticationInitial()) {
    // login
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());
      (await _authRepository.loginViaEmail(event.loginRequest)).fold((failure) {
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
          if (user.safeToContinue()) {
            emit(AuthenticationSuccess(user: user));
          }
        }
      }));
    });

    on<GoogleLoginButtonPressed>(
      (event, emit) async {
        emit(AuthenticationInProgress());
        await (await _authRepository.loginViaGoogle()).fold(
          (failure) {
            emit(AuthenticationFailed(failure.message));
          },
          (user) {
            if (user.phoneNumber.isEmpty) {
              emit(PhoneNumberNeeded());
            } else {
              emit(AuthenticationSuccess(user: user));
            }
          },
        );
      },
    );

    on<MobileNumberEntered>((event, emit) async {
      await (await _authRepository.getCurrentUserIfExists()).fold(
        ((failure) {
          emit(AuthenticationFailed(failure.message));
        }),
        ((user) async {
          if (user == null) {
            emit(AuthenticationFailed(''));
          } else {
            user = user.copyWith(phoneNumber: event.mobileNumber);
            (await _authRepository.updateUserData(user)).fold(((failure) {
              emit(AuthenticationFailed(failure.message));
            }), ((user) {
              emit(AuthenticationSuccess(user: user));
            }));
          }
        }),
      );
    });

    on<LogOut>(
      (event, emit) async {
        await _authRepository.logOut();
        emit(AuthenticationInitial());
      },
    );

    on<SendVerificationCode>(
      (event, emit) async {
        await _authRepository.sendVerificationCode(event.number, event.code);
      },
    );
  }
}
