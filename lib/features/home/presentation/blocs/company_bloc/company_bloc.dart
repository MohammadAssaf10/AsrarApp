import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/company_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  CompanyBloc() : super(CompanyInitial()) {
    on<CompanyEvent>((event, emit) async {
      if (event is GetCompanyEvent) {
        emit(CompanyLoadingState());
        final company = await homeRepository.getCompanies();
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
