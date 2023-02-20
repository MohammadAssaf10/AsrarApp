import 'dart:convert';


import '../../../auth/domain/entities/user.dart';
import 'employee.dart';
import 'service_entities.dart';


/// [status] must be one of the [OrderStatus]
class ServiceOrder {
  final int id;
  final ServiceEntities service;
  final User user;
  final Employee employee;
  final String status;

  ServiceOrder({
    required this.id,
    required this.service,
    required this.user,
    required this.employee,
    required this.status,
  });

  ServiceOrder copyWith({
    int? id,
    ServiceEntities? service,
    User? user,
    Employee? employee,
    String? status,
  }) {
    return ServiceOrder(
      id: id ?? this.id,
      service: service ?? this.service,
      user: user ?? this.user,
      employee: employee ?? this.employee,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'service': service.toMap()});
    result.addAll({'user': user.toMap()});
    result.addAll({'employee': employee.toMap()});
    result.addAll({'status': status});

    return result;
  }

  factory ServiceOrder.fromMap(Map<String, dynamic> map) {
    return ServiceOrder(
      id: map['id']?.toInt() ?? 0,
      service: ServiceEntities.fromMap(map['service'] ?? {}),
      user: User.fromMap(map['user']),
      employee: Employee.fromMap(map['employee'] ?? {}),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrder.fromJson(String source) => ServiceOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceOrder(id: $id, service: $service, user: $user, employee: $employee, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceOrder &&
        other.id == id &&
        other.service == service &&
        other.user == user &&
        other.employee == employee &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ service.hashCode ^ user.hashCode ^ employee.hashCode ^ status.hashCode;
  }
}
