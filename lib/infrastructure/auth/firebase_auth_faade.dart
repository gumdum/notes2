import 'package:dfunc/dfunc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:notes2/domain/auth/auth_failure.dart';
import 'package:notes2/domain/auth/i_auth_facade.dart';
import 'package:notes2/domain/auth/value_objects.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthFacade(
    this._firebaseAuth,
  );

  //! Register with email & Pass
  @override
  Future<Either<AuthFailure, Coproduct0>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return const Either.right(Coproduct0.empty());
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return const Either.left(AuthFailure.emailAlreadyInUse());
      } else {
        return const Either.left(AuthFailure.serverError());
      }
    }
  }

  //! Google Sign In Button - changed, see:
  //! https://github.com/flutter/plugins/blob/master/packages/google_sign_in/google_sign_in/example/lib/main.dart
  @override
  Future<Either<AuthFailure, Coproduct0>> signInWithGoogle() async {
    return const Either.right(Coproduct0.empty());
  }

  //!Google Sign In With Email & Password
  @override
  Future<Either<AuthFailure, Coproduct0>> signinWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return const Either.right(Coproduct0.empty());
    } on PlatformException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return const Either.left(
            AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return const Either.left(AuthFailure.serverError());
      }
    }
  }
}
