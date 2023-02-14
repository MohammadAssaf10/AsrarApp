part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();
}
class GetServices extends ServicesEvent{
  final String companyName;
  const GetServices({required this.companyName});
    @override
  List<Object> get props => [companyName];
}