import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('\x1B[30m onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('\x1B[35m onEvent -- ${bloc.runtimeType},\n\x1B[35m $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('\x1B[36m onTransition -- ${bloc.runtimeType},\n\x1B[36m $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint(
        '\x1B[32monChange -- ${bloc.runtimeType},\n\x1B[32mcurrentState: ${change.currentState}\n\x1B[32mnextState: ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('\x1B[31m onError -- ${bloc.runtimeType},\n\x1B[31m $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('\x1B[30m onClose -- ${bloc.runtimeType}');
  }
}
