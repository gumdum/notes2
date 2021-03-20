import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes2/domain/auth/auth_failure.dart';
import 'package:notes2/domain/auth/i_auth_facade.dart';
import 'package:notes2/domain/auth/value_objects.dart';
import 'package:oxidized/oxidized.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  @override
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      //run it through the EmailAddress() validator
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureorSuccessOption:
              None(), //reset failure message if authFailure is not safe-null
        );
      },

      //run it through the Password() validator
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureorSuccessOption: None(),
        );
      },

      //! register sign in
      registerWithEmailAndPasswordPressed: (e) async* {
        final isEmailValid = state.emailAddress!.value.isRight();
        final isPasswordValid = state.emailAddress!.value.isRight();

        if (isEmailValid && isPasswordValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFailureorSuccessOption: None(),
          );

          final failureOrSuccess =
              await _authFacade.registerWithEmailAndPassword(
                  emailAddress: (state.emailAddress)!,
                  password: (state.password)!);
          yield state.copyWith(
            isSubmitting: false,
            authFailureorSuccessOption: Some(failureOrSuccess),
          );
        }

        //handle invalid email or password
        yield state.copyWith(
          showErrorMessages: true,
          authFailureorSuccessOption: None(),
        );
      },

      //! User sign in
      signInWithEmailAndPasswordPressed: (e) async* {
        final isEmailValid = state.emailAddress!.value.isRight();
        final isPasswordValid = state.emailAddress!.value.isRight();

        if (isEmailValid && isPasswordValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFailureorSuccessOption: None(),
          );

          final failureOrSuccess = await _authFacade.signinWithEmailAndPassword(
              emailAddress: (state.emailAddress)!, password: (state.password)!);
          yield state.copyWith(
            isSubmitting: false,
            authFailureorSuccessOption: Some(failureOrSuccess),
          );
        }

        //handle invalid email or password
        yield state.copyWith(
          showErrorMessages: true,
          authFailureorSuccessOption: None(),
        );
      },

      //!Google signin
      signInWithGooglePressed: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureorSuccessOption: None(),
        );

        final failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureorSuccessOption: Some(failureOrSuccess),
        );
      },
    );
  }
}

//TODO : Make a function below that will remove the duplication code
// of: registerwithemailandpassword
// signin with email and password
