import 'package:equatable/equatable.dart';

class AdImageEntities extends Equatable {
  final String adImageName;
  final String adImageUrl;
  final String adImagedeepLink;
  const AdImageEntities({
    required this.adImageName,
    required this.adImageUrl,
    required this.adImagedeepLink,
  });
  @override
  List<Object> get props => [
        adImageName,
        adImageUrl,
        adImagedeepLink,
      ];

  factory AdImageEntities.fromMap(Map<String, dynamic> map) {
    return AdImageEntities(
      adImageName: map['adImageName'],
      adImageUrl: map['adImageUrl'],
      adImagedeepLink: map['adImagedeepLink'],
    );
  }

  @override
  String toString() =>
      'AdImageEntities(adImageName: $adImageName, adImageUrl: $adImageUrl, adImagedeepLink: $adImagedeepLink)';
}
