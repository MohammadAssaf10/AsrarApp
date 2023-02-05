import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes_manager.dart';
import 'features/auth/presentation/bloc/authentication_bloc.dart';
import 'language_cubit/language_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.auth);
              },
              child: Text('Auth')),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.verificationView);
              },
              child: Text('verification')),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LogOut());
              },
              child: Text('logout')),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.homeRoute);
              },
              child: Text('Home')),
          ElevatedButton(
              onPressed: () {
                final code = Random().nextInt(9999);
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(SendVerificationCode('963931464912', code.toString()));
              },
              child: Text('send verification code')),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print('ar');
                    context.read<LanguageCubit>().setArabic();
                  },
                  child: Text('ar')),
              ElevatedButton(
                  onPressed: () {
                    print('en');
                    context.read<LanguageCubit>().setEnglish();
                  },
                  child: Text('en')),
            ],
          )
        ],
      )),
    );
  }
}
