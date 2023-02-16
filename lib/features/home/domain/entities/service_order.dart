import 'dart:convert';

import '../../../auth/domain/entities/user.dart';
import 'service_entities.dart';

/// [status] must be one of the [OrderStatus] 
class ServiceOrder {
  final int id;
  final ServiceEntities service;
  final UserEntities user;
  final String status;

  ServiceOrder({
    required this.id,
    required this.service,
    required this.user,
    required this.status,
  });

  ServiceOrder copyWith({
    int? id,
    ServiceEntities? service,
    UserEntities? user,
    String? status,
  }) {
    return ServiceOrder(
      id: id ?? this.id,
      service: service ?? this.service,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'service': service.toMap()});
    result.addAll({'user': user.toMap()});
    result.addAll({'status': status});

    return result;
  }

  factory ServiceOrder.fromMap(Map<String, dynamic> map) {
    return ServiceOrder(
      id: map['id']?.toInt() ?? 0,
      service: ServiceEntities.fromMap(map['service']),
      user: UserEntities.fromMap(map['user']),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrder.fromJson(String source) => ServiceOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceOrder(id: $id, service: $service, user: $user, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceOrder &&
        other.id == id &&
        other.service == service &&
        other.user == user &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ service.hashCode ^ user.hashCode ^ status.hashCode;
  }
}
