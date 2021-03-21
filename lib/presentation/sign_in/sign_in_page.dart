import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes2/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:notes2/injection.dart';
import 'package:notes2/presentation/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: BlocProvider(
          create: (context) => getIt<SignInFormBloc>(), child: SignInForm()),
    );
  }
}
