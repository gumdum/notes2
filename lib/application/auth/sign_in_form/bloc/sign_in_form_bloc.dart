import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dfunc/dfunc.dart';
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
    // TODO: implement mapEventToState
  }
}
