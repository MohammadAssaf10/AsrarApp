import 'package:asrar_app/features/home/domain/entities/company_entities.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/get_company.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyUseCase getCompanyUseCase;

  CompanyBloc({required this.getCompanyUseCase}) : super(CompanyInitial()) {
    on<CompanyEvent>((event, emit) async {
      if (event is GetCompanyEvent) {
        emit(CompanyLoadingState());
        final company = await getCompanyUseCase();
        company.fold(
          (failure) => emit(CompanyErrorState(errorMessage: failure.message)),
          (company) => emit(
            CompanyLoadedState(company: company),
          ),
        );
      }
    });
  }
}
