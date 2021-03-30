import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes2/application/auth/auth_bloc.dart';
import 'package:notes2/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) => printMessage('initial'),
          authenticated: (_) => printMessage('I am signed in'),
          unauthenticated: (_) =>
              AutoRouter.of(context).push(const SignInRoute()),
        );
      },
      child: _PageWidget(),
    );
  }
}

void printMessage(String message) {
  // ignore: avoid_print
  print(message);
}

class _PageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
