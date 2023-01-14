part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
}

class GetCompanyEvent extends CompanyEvent {
  @override
  List<Object?> get props => [];
}
