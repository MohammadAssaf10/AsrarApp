part of 'terms_of_use_bloc.dart';

enum TermsOfUseStatus {
  initial,
  loading,
  error,
  loaded
}

class TermsOfUseState extends Equatable {
  final TermsOfUseStatus status;
  final String termsOfUse;
  final String errorMessage;
  const TermsOfUseState(
      {this.status = TermsOfUseStatus.initial,
      this.termsOfUse = "",
      this.errorMessage = ""});

  @override
  List<Object> get props => [status, termsOfUse, errorMessage];

  TermsOfUseState copyWith({
    TermsOfUseStatus? status,
    String? termsOfUse,
    String? errorMessage,
  }) {
    return TermsOfUseState(
      status: status ?? this.status,
      termsOfUse: termsOfUse ?? this.termsOfUse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'TermsOfUseState(status: $status, termsOfUse: $termsOfUse, errorMessage: $errorMessage)';
}
