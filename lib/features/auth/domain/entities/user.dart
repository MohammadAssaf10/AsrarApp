import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String id;
  String tapId;
  String name;
  String email;
  String phoneNumber;
  String imageURL;
  String imageName;
  List<String> userTokenList;

  User({
    required this.id,
    required this.tapId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.imageURL,
    required this.imageName,
    required this.userTokenList,
  });

  User copyWith({
    String? id,
    String? tapId,
    String? name,
    String? email,
    String? phoneNumber,
    String? imageURL,
    String? imageName,
    List<String>? userTokenList,
  }) {
    return User(
      id: id ?? this.id,
      tapId: tapId ?? this.tapId,
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
  
    result.addAll({'id': id});
    result.addAll({'tapId': tapId});
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
      id: map['id'] ?? '',
      tapId: map['tapId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageURL: map['imageURL'] ?? '',
      imageName: map['imageName'] ?? '',
      userTokenList: List<String>.from(map['userTokenList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, tapId: $tapId, name: $name, email: $email, phoneNumber: $phoneNumber, imageURL: $imageURL, imageName: $imageName, userTokenList: $userTokenList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.tapId == tapId &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.imageURL == imageURL &&
      other.imageName == imageName &&
      listEquals(other.userTokenList, userTokenList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tapId.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      imageURL.hashCode ^
      imageName.hashCode ^
      userTokenList.hashCode;
  }

  /// true if all sensitive filed actually has data
  bool safeToContinue() {
    return (email.isNotEmpty &&
        name.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        userTokenList.isNotEmpty);
  }
}
