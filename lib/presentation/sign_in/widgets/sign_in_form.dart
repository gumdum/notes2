import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes2/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      //! listener is for the snackbar
      listener: (context, state) {
        state.authFailureorSuccessOption!.when(
          some: (value) => value.fold(
            (failure) {
              FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Cancelled',
                  featureNotAvailable: (_) => 'Feature not available',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              ).show(context);
            },
            (_) {
              //TODO: Navigate
            },
          ),
          none: () {},
        );
      },
      builder: (context, state) {
        return Form(
          //!TODO state.showErrorMessages deprecated, remove from code
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                '📝',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 130),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: 'Email'),
                autocorrect: false,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) =>
                    //!get state from the Bloc and not builder to keep up with input
                    BlocProvider.of<SignInFormBloc>(context)
                        .state
                        .emailAddress
                        .value
                        .fold(
                            (f) => f.map(
                                invalidEmail: (_) => 'Invalid Email String',
                                shortPassword: (_) => 'Password too short'),
                            (r) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock), labelText: 'Password'),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) =>
                    //!get state from the Bloc and not builder to keep up with input
                    BlocProvider.of<SignInFormBloc>(context)
                        .state
                        .password
                        .value
                        .fold(
                            (f) => f.maybeMap(
                                shortPassword: (_) => 'Invalid Password',
                                orElse: () => null),
                            (r) => null),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                            const SignInFormEvent
                                .signInWithEmailAndPasswordPressed());
                      },
                      child: const Text('SIGN IN'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                            const SignInFormEvent
                                .registerWithEmailAndPasswordPressed());
                      },
                      child: const Text('REGISTER'),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignInFormBloc>(context)
                      .add(const SignInFormEvent.signInWithGooglePressed());
                },
                child: const Text('SIGN IN WITH GOOGLE'),
              ),
            ],
          ),
        );
      },
    );
  }
}
