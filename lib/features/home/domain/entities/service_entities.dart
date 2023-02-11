import 'dart:convert';

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

  factory ServiceEntities.fromMap(Map<String, dynamic> map) {
    return ServiceEntities(
      companyName: map['companyName'] ?? '',
      serviceName: map['serviceName'] ?? '',
      servicePrice: map['servicePrice'] ?? '',
      requiredDocuments: List<dynamic>.from(map['requiredDocuments']),
    );
  }

  @override
  String toString() {
    return 'ServiceEntities(companyName: $companyName, serviceName: $serviceName, servicePrice: $servicePrice, requiredDocuments: $requiredDocuments)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'companyName': companyName});
    result.addAll({'serviceName': serviceName});
    result.addAll({'servicePrice': servicePrice});
    result.addAll({'requiredDocuments': requiredDocuments});
  
    return result;
  }

  String toJson() => json.encode(toMap());

  factory ServiceEntities.fromJson(String source) => ServiceEntities.fromMap(json.decode(source));
}
