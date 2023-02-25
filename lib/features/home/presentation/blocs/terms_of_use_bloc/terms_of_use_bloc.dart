import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/repository/home_repository.dart';

part 'terms_of_use_event.dart';
part 'terms_of_use_state.dart';

class TermsOfUseBloc extends Bloc<TermsOfUseEvent, TermsOfUseState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  TermsOfUseBloc() : super(const TermsOfUseState()) {
    on<GetTermsOfUseEvent>((event, emit) async {
      emit(state.copyWith(status: TermsOfUseStatus.loading));
      (await homeRepository.getTermsOfUse()).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: TermsOfUseStatus.error));
      }, (termOfUse) {
        emit(state.copyWith(
            termsOfUse: termOfUse, status: TermsOfUseStatus.loaded));
      });
    });
  }
}
