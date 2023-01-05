import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/strings_manager.dart';
import '../../../../../core/app/extensions.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // to make sure that all field value was changed on time at list
  bool _emailEntered = false;
  bool _passwordEntered = false;

  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      _emailEntered = true;
      _onEmailChanged(event, emit);
      _areAllInputsAccepted(emit);
    });
    on<PasswordChanged>((event, emit) {
      _passwordEntered = true;
      _onPasswordChanged(event, emit);
      _areAllInputsAccepted(emit);
    });
  }

  _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    if (event.email.nullOrEmpty()) {
      emit(state.copyWith(
          emailErrorMessage: AppStrings.pleaseEnterEmail));
    }
    else {
      emit(state.copyWith(emailErrorMessage: ''));
    }
  }

  _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    if (event.password.nullOrEmpty()) {
      emit(
          state.copyWith(passwordErrorMessage: AppStrings.pleaseEnterPassword));
    }
    else {
      emit(state.copyWith(passwordErrorMessage: ''));
    }
  }

  _areAllInputsAccepted(Emitter<LoginState> emit) {
    if (state.emailErrorMessage == null &&
        state.passwordErrorMessage == null &&
        _emailEntered &&
        _passwordEntered) {
      emit(state.copyWith(status: Status.accepted));
    } else {
      emit(state.copyWith(status: Status.notAccepted));
    }
  }
}
