import 'dart:convert';

import '../../../../core/app/constants.dart';
import '../../../auth/domain/entities/user.dart';
import 'employee.dart';
import 'service_entities.dart';

/// [status] must be one of the [OrderStatus]
// when regenerate data class remove the employee form [toMap]
class ServiceOrder {
  final int id;
  final String chargeId;
  final ServiceEntities service;
  final User user;
  final Employee employee;
  final String status;

  ServiceOrder({
    required this.id,
    required this.chargeId,
    required this.service,
    required this.user,
    required this.employee,
    required this.status,
  });

  ServiceOrder.newRequest({required this.service, required this.user, required this.chargeId})
      : id = 0,
        employee = Employee.fromMap({}),
        status = OrderStatus.pending.name;

  ServiceOrder copyWith({
    int? id,
    String? chargeId,
    ServiceEntities? service,
    User? user,
    Employee? employee,
    String? status,
  }) {
    return ServiceOrder(
      id: id ?? this.id,
      chargeId: chargeId ?? this.chargeId,
      service: service ?? this.service,
      user: user ?? this.user,
      employee: employee ?? this.employee,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'chargeId': chargeId});
    result.addAll({'service': service.toMap()});
    result.addAll({'user': user.toMap()});
    result.addAll({'status': status});

    return result;
  }

  factory ServiceOrder.fromMap(Map<String, dynamic> map) {
    return ServiceOrder(
      id: map['id']?.toInt() ?? 0,
      chargeId: map['chargeId'] ?? '',
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
    return 'ServiceOrder(id: $id, chargeId: $chargeId, service: $service, user: $user, employee: $employee, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceOrder &&
        other.id == id &&
        other.chargeId == chargeId &&
        other.service == service &&
        other.user == user &&
        other.employee == employee &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chargeId.hashCode ^
        service.hashCode ^
        user.hashCode ^
        employee.hashCode ^
        status.hashCode;
  }
}
