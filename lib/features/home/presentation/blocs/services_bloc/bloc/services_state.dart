part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class ServicesInitial extends ServicesState {
  @override
  List<Object?> get props => [];
}

class LoadingServicesState extends ServicesState {
  @override
  List<Object?> get props => [];
}

class ErrorServicesState extends ServicesState {
  final String errorMessage;
  const ErrorServicesState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class LoadedServicesState extends ServicesState {
  final List<ServiceEntities> services;
  const LoadedServicesState({required this.services});
  @override
  List<Object?> get props => [services];
}
