import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String name;
  String email;
  String phoneNumber;
  List<String> userTokenList;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.userTokenList,
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    List<String>? userTokenList,
  }) {
    return User(
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userTokenList: List<String>.from(map['userTokenList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, phoneNumber: $phoneNumber, userTokenList: $userTokenList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
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
