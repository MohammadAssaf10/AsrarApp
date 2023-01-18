import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/service_entities.dart';
import '../../../../domain/use_cases/get_services.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetServicesUseCase getServicesUseCase = GetServicesUseCase();
  ServicesBloc() : super(ServicesInitial()) {
    on<GetServices>((event, emit) async {
      emit(LoadingServicesState());
      final services = await getServicesUseCase(event.companyName);
      services.fold(
          (failure) => emit(ErrorServicesState(errorMessage: failure.message)),
          (services) => emit(LoadedServicesState(services: services)));
    });
  }
}
