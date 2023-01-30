import 'dart:convert';

class User {
  String name;
  String email;
  String phoneNumber;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(name: $name, email: $email, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ phoneNumber.hashCode;
}
