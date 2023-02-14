import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/app/di.dart';
import '../../../domain/entities/service_entities.dart';
import '../../../domain/repository/home_repository.dart';


part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  ServicesBloc() : super(ServicesInitial()) {
    on<GetServices>((event, emit) async {
      emit(LoadingServicesState());
      final services = await homeRepository.getServices(event.companyName);
      services.fold(
          (failure) => emit(ErrorServicesState(errorMessage: failure.message)),
          (services) => emit(LoadedServicesState(services: services)));
    });
  }
}
