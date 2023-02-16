import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserEntities {
  String name;
  String email;
  String phoneNumber;
  List<String> userTokenList;

  UserEntities({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.userTokenList,
  });

  UserEntities copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    List<String>? userTokenList,
  }) {
    return UserEntities(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userTokenList: userTokenList ?? this.userTokenList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'userTokenList': userTokenList,
    };
  }

  factory UserEntities.fromMap(Map<String, dynamic> map) {
    return UserEntities(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userTokenList: List<String>.from(map['userTokenList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntities.fromJson(String source) => UserEntities.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, phoneNumber: $phoneNumber, userTokenList: $userTokenList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntities &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.userTokenList, userTokenList);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        userTokenList.hashCode;
  }

  /// true if all sensitive filed actually has data
  bool safeToContinue() {
    return (this.email.isNotEmpty &&
        this.name.isNotEmpty &&
        this.phoneNumber.isNotEmpty &&
        this.userTokenList.isNotEmpty);
  }
}
