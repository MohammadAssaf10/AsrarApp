import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/job_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  JobBloc() : super(JobInitial()) {
    on<GetJobsListEvent>((event, emit) async {
      emit(JobLoadingState());
      (await homeRepository.getJobs()).fold((failure) {
        emit(JobErrorState(errorMessage: failure.message));
      }, (jobsList) {
        emit(JobsLoadedState(jobsList: jobsList));
      });
    });
  }
}
