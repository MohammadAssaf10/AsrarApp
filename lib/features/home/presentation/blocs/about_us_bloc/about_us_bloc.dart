import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/repository/home_repository.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  AboutUsBloc() : super(const AboutUsState()) {
    on<GetAbuotUsEvent>((event, emit) async {
      emit(state.copyWith(status: AboutUsStatus.loading));
      (await homeRepository.getAboutUs()).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: AboutUsStatus.error));
      }, (aboutUs) {
        emit(state.copyWith(aboutUs: aboutUs, status: AboutUsStatus.loaded));
      });
    });
  }
}
