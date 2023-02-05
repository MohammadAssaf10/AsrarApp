import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes_manager.dart';
import 'features/auth/presentation/bloc/authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthStatus.init)
            Navigator.pushReplacementNamed(context, Routes.auth);
          else if (state.status == AuthStatus.loggedIn)
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          else
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(child: CircularProgressIndicator());
              },
            );
        },
        child: Center(),
      ),
    );
  }
}
