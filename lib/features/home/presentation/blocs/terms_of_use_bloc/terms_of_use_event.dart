part of 'terms_of_use_bloc.dart';

abstract class TermsOfUseEvent extends Equatable {
  const TermsOfUseEvent();
}

class GetTermsOfUseEvent extends TermsOfUseEvent {
  @override
  List<Object?> get props => [];
}
