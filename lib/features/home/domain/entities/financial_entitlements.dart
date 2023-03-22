import 'dart:convert';

// ignore_for_file: file_names

class FinancialEntitlements {
  String beneficiaryId;
  String beneficiaryNumber;
  String beneficiaryEmail;
  double amount;

  FinancialEntitlements({
    required this.beneficiaryId,
    required this.beneficiaryNumber,
    required this.beneficiaryEmail,
    required this.amount,
  });

  FinancialEntitlements copyWith({
    String? beneficiaryId,
    String? beneficiaryNumber,
    String? beneficiaryEmail,
    double? amount,
  }) {
    return FinancialEntitlements(
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      beneficiaryNumber: beneficiaryNumber ?? this.beneficiaryNumber,
      beneficiaryEmail: beneficiaryEmail ?? this.beneficiaryEmail,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'beneficiaryId': beneficiaryId});
    result.addAll({'beneficiaryNumber': beneficiaryNumber});
    result.addAll({'beneficiaryEmail': beneficiaryEmail});
    result.addAll({'amount': amount});
  
    return result;
  }

  factory FinancialEntitlements.fromMap(Map<String, dynamic> map) {
    return FinancialEntitlements(
      beneficiaryId: map['beneficiaryId'] ?? '',
      beneficiaryNumber: map['beneficiaryNumber'] ?? '',
      beneficiaryEmail: map['beneficiaryEmail'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialEntitlements.fromJson(String source) => FinancialEntitlements.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FinancialEntitlements(beneficiaryId: $beneficiaryId, beneficiaryNumber: $beneficiaryNumber, beneficiaryEmail: $beneficiaryEmail, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FinancialEntitlements &&
      other.beneficiaryId == beneficiaryId &&
      other.beneficiaryNumber == beneficiaryNumber &&
      other.beneficiaryEmail == beneficiaryEmail &&
      other.amount == amount;
  }

  @override
  int get hashCode {
    return beneficiaryId.hashCode ^
      beneficiaryNumber.hashCode ^
      beneficiaryEmail.hashCode ^
      amount.hashCode;
  }
}
