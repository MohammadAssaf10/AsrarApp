import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/strings_manager.dart';
import '../../../../../core/app/functions.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<EmailChanged>((event, emit) {
      if (isEmailFormatCorrect(event.email ?? '')) {
        emit(state.copyWith(
            emailStatus: Status.accepted, emailErrorMessage: ''));
      } else {
        emit(state.copyWith(
            emailStatus: Status.notAccepted,
            emailErrorMessage: AppStrings.emailFormatNotCorrect));
      }
    });

    on<SendVerificationCodeButtonPressed>((event, emit) {
      emit(state.copyWith(isSendVerificationButton: true));
    });
  }
}
