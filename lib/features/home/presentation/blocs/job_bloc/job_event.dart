part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();
}

class GetJobsListEvent extends JobEvent {
  @override
  List<Object?> get props => [];
}
