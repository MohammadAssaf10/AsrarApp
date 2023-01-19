import 'package:equatable/equatable.dart';

class ServiceEntities extends Equatable {
  final String companyName;
  final String serviceName;
  final String servicePrice;
  final List<dynamic> requiredDocuments;

  const ServiceEntities({
    required this.companyName,
    required this.serviceName,
    required this.servicePrice,
    required this.requiredDocuments,
  });

  @override
  List<Object?> get props => [
        companyName,
        serviceName,
        servicePrice,
        requiredDocuments,
      ];

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'requiredDocuments': requiredDocuments,
    };
  }

  factory ServiceEntities.fromMap(Map<String, dynamic> map) {
    return ServiceEntities(
      companyName: map['companyName'] as String,
      serviceName: map['serviceName'] as String,
      servicePrice: map['servicePrice'] as String,
      requiredDocuments: map['requiredDocuments'] as List<String>,
    );
  }
}
