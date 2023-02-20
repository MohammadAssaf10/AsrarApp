import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String name;
  String email;
  String phoneNumber;
  String imageURL;
  String imageName;
  List<String> userTokenList;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.imageURL,
    required this.imageName,
    required this.userTokenList,
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? imageURL,
    String? imageName,
    List<String>? userTokenList,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageURL: imageURL ?? this.imageURL,
      imageName: imageName ?? this.imageName,
      userTokenList: userTokenList ?? this.userTokenList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'imageURL': imageURL});
    result.addAll({'imageName': imageName});
    result.addAll({'userTokenList': userTokenList});
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageURL: map['imageURL'] ?? '',
      imageName: map['imageName'] ?? '',
      userTokenList: List<String>.from(map['userTokenList'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, phoneNumber: $phoneNumber, imageURL: $imageURL, imageName: $imageName, userTokenList: $userTokenList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.imageURL == imageURL &&
        other.imageName == imageName &&
        listEquals(other.userTokenList, userTokenList);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        imageURL.hashCode ^
        imageName.hashCode ^
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
