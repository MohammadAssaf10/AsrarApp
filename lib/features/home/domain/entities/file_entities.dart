import 'package:equatable/equatable.dart';

class FileEntities extends Equatable {
  final String name;
  final String url;

  const FileEntities({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];

  @override
  String toString() => 'FileEntities(name: $name, url: $url)';
}
