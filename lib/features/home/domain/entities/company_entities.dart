import 'package:equatable/equatable.dart';

class CompanyEntities extends Equatable {
  final int companyRanking;
  final String fullName; // Name with subsequent(.jpg or .png)
  final String name;
  final String image;

  const CompanyEntities({
    required this.companyRanking,
    required this.fullName,
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyRanking': companyRanking,
      'fullName': fullName,
      'name': name,
      'image': image,
    };
  }

  factory CompanyEntities.fromMap(Map<String, dynamic> map) {
    return CompanyEntities(
      companyRanking: map['companyRanking'],
      fullName: map['fullName'],
      name: map['name'],
      image: map['image'],
    );
  }

  @override
  List<Object?> get props => [companyRanking, fullName, name, image];

  @override
  String toString() {
    return 'CompanyEntities(companyRanking: $companyRanking, fullName: $fullName, name: $name, image: $image)';
  }
}
