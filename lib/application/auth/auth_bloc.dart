import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:notes2/domain/auth/i_auth_facade.dart';
import 'package:oxidized/oxidized.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(
    this._authFacade,
  ) : super(const AuthState.initial());

  //AuthState get initialState => const AuthState.initial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      //what do we want to do if authcheck is requested?
      authCheckRequested: (e) async* {
        final userOption = await _authFacade.getSignedInUser();

        yield userOption == Option.none()
            ? const AuthState.unauthenticated()
            : const AuthState.authenticated();
      },
      signedOut: (e) async* {
        await _authFacade.signOUt();
        yield const AuthState.unauthenticated();
      },
    );
  }
}
