import 'package:equatable/equatable.dart';

class CompanyEntities extends Equatable {
  final String name;
  final String image;

  const CompanyEntities({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];

}
