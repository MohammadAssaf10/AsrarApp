import 'package:equatable/equatable.dart';

class CompanyEntities extends Equatable {
  final String fullName;
  final String name;
  final String image;

  const CompanyEntities({
    required this.fullName,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [fullName, name, image];
}
