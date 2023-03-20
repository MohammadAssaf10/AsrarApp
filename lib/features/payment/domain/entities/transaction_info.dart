// ignore_for_file: non_constant_identifier_names

class ChargeInfo {
  String charge_id;
  String source_id;
  String customer_id;
  ChargeInfo({
    required this.charge_id,
    required this.source_id,
    required this.customer_id,
  });

  ChargeInfo copyWith({
    String? charge_id,
    String? source_id,
    String? customer_id,
  }) {
    return ChargeInfo(
      charge_id: charge_id ?? this.charge_id,
      source_id: source_id ?? this.source_id,
      customer_id: customer_id ?? this.customer_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'charge_id': charge_id});
    result.addAll({'source_id': source_id});
    result.addAll({'customer_id': customer_id});

    return result;
  }

  factory ChargeInfo.fromMap(Map<String, dynamic> map) {
    return ChargeInfo(
      charge_id: map['charge_id'] ?? '',
      source_id: map['source_id'] ?? '',
      customer_id: map['customer_id'] ?? '',
    );
  }

  @override
  String toString() =>
      'ChargeInfo(charge_id: $charge_id, source_id: $source_id, customer_id: $customer_id)';
}
