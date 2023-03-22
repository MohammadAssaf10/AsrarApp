import 'dart:convert';

class Employee {
  String employeeID;
  String name;
  String email;
  String phonNumber;
  String idNumber;
  String national;

  Employee({
    required this.employeeID,
    required this.name,
    required this.email,
    required this.phonNumber,
    required this.idNumber,
    required this.national,
  });

  Employee copyWith({
    String? employeeID,
    String? name,
    String? email,
    String? phonNumber,
    String? idNumber,
    String? national,
  }) {
    return Employee(
      employeeID: employeeID ?? this.employeeID,
      name: name ?? this.name,
      email: email ?? this.email,
      phonNumber: phonNumber ?? this.phonNumber,
      idNumber: idNumber ?? this.idNumber,
      national: national ?? this.national,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'employeeID': employeeID});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phonNumber': phonNumber});
    result.addAll({'idNumber': idNumber});
    result.addAll({'national': national});
  
    return result;
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeID: map['employeeID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phonNumber: map['phonNumber'] ?? '',
      idNumber: map['idNumber'] ?? '',
      national: map['national'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) => Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(employeeID: $employeeID, name: $name, email: $email, phonNumber: $phonNumber, idNumber: $idNumber, national: $national)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Employee &&
      other.employeeID == employeeID &&
      other.name == name &&
      other.email == email &&
      other.phonNumber == phonNumber &&
      other.idNumber == idNumber &&
      other.national == national;
  }

  @override
  int get hashCode {
    return employeeID.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phonNumber.hashCode ^
      idNumber.hashCode ^
      national.hashCode;
  }
}
