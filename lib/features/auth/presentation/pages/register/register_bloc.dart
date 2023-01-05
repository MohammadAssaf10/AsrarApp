import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/strings_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../../../core/app/extensions.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // to make sure that all field value was changed on time at list
  bool _nameEntered = false;
  bool _emailEntered = false;
  bool _mobileNumberEntered = false;
  bool _passwordEntered = false;

  RegisterBloc() : super(const RegisterState()) {
    on<NameChanged>((event, emit) {
      _onNameChanged(event, emit);
      _areAllInputAccepted(emit);
    });

    on<EmailChanged>((event, emit) {
      _onEmailChanged(event, emit);
      _areAllInputAccepted(emit);
    });

    on<MobileNumberChanged>((event, emit) {
      _onMobileNumberChanged(event, emit);
      _areAllInputAccepted(emit);
    });

    on<PasswordChanged>((event, emit) {
      _onPasswordChanged(event, emit);
      _areAllInputAccepted(emit);
    });
  }

  _onNameChanged(NameChanged event, Emitter<RegisterState> emit) {
    _nameEntered = true;
    if (event.name.nullOrEmpty()) {
      emit(state.copyWith(
          nameErrorMessage: AppStrings.pleaseEnterName));
    } else if ((event.name?.length ?? 0) < 3) {
      emit(state.copyWith(
          nameErrorMessage:
              AppStrings.nameShouldAtLeast3Character));
    } else {
      emit(state.copyWith(nameErrorMessage: ''));
    }
  }

  _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    _emailEntered = true;
    if (event.email.nullOrEmpty()) {
      emit(state.copyWith(
          emailErrorMessage: AppStrings.pleaseEnterEmail));
    } else if (!isEmailFormatCorrect(event.email ?? '')) {
      emit(state.copyWith(
          emailErrorMessage: AppStrings.emailFormatNotCorrect));
    } else {
      emit(state.copyWith(emailErrorMessage: ''));
    }
  }

  _onMobileNumberChanged(
      MobileNumberChanged event, Emitter<RegisterState> emit) {
    _mobileNumberEntered = true;
    if (event.mobileNumber.nullOrEmpty()) {
      emit(state.copyWith(
          mobileNumberErrorMessage:
              AppStrings.pleaseEnterMobileNumber));
    } else if (!isMobileNumberCorrect(event.mobileNumber ?? '')) {
      emit(state.copyWith(
          mobileNumberErrorMessage:
              AppStrings.mobileNumberFormatNotCorrect));
    } else if ((event.mobileNumber?.length ?? 0) < 5) {
      emit(state.copyWith(
          mobileNumberErrorMessage:
              AppStrings.mobileNumberShouldAtLeast5Character));
    } else {
      emit(state.copyWith(mobileNumberErrorMessage: ''));
    }
  }

  _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    _passwordEntered = true;
    if (event.password.nullOrEmpty()) {
      emit(state.copyWith(
          passwordErrorMessage: AppStrings.pleaseEnterPassword));
    } else if ((event.password?.length ?? 0) < 6) {
      emit(state.copyWith(
          passwordErrorMessage:
              AppStrings.passwordShouldAtLeast6Character));
    } else {
      emit(state.copyWith(passwordErrorMessage: ''));
    }
  }

  _areAllInputAccepted(Emitter<RegisterState> emit) {
    if (_nameEntered &&
        _emailEntered &&
        _mobileNumberEntered &&
        _passwordEntered) {
      if (state.nameErrorMessage == null &&
          state.emailErrorMessage == null &&
          state.mobileNumberErrorMessage == null &&
          state.passwordErrorMessage == null) {
        emit(state.copyWith(status: Status.accepted));
      }
    }
  }
}
