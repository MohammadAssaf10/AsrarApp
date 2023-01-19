part of 'company_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();
}

class CompanyInitial extends CompanyState {
  @override
  List<Object> get props => [];
}

class CompanyLoadingState extends CompanyState {
  @override
  List<Object?> get props => [];
}

class CompanyErrorState extends CompanyState {
  final String errorMessage;

  const CompanyErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class CompanyLoadedState extends CompanyState {
  final List<CompanyEntities> company;

  const CompanyLoadedState({required this.company});

  @override
  List<Object?> get props => [company];
}
