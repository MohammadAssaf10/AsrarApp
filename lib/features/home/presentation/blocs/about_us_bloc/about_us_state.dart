part of 'about_us_bloc.dart';

enum AboutUsStatus {
  initial,
  loading,
  error,
  loaded
}

class AboutUsState extends Equatable {
  final AboutUsStatus status;
  final String aboutUs;
  final String errorMessage;
  const AboutUsState(
      {this.status = AboutUsStatus.initial,
      this.aboutUs = "",
      this.errorMessage = ""});

  @override
  List<Object> get props => [status, aboutUs, errorMessage];

  AboutUsState copyWith({
    AboutUsStatus? status,
    String? aboutUs,
    String? errorMessage,
  }) {
    return AboutUsState(
      status: status ?? this.status,
      aboutUs: aboutUs ?? this.aboutUs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'AboutUsState(status: $status, aboutUs: $aboutUs, errorMessage: $errorMessage)';
}
