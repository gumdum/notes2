import 'package:dfunc/dfunc.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:notes2/domain/auth/auth_failure.dart';
import 'package:notes2/domain/auth/i_auth_facade.dart';
import 'package:notes2/domain/auth/user.dart';
import 'package:notes2/domain/auth/value_objects.dart';
import 'package:notes2/presentation/splash/splash_page.dart';
import 'package:oxidized/oxidized.dart';
import 'package:notes2/infrastructure/auth/firebase_user_mapper.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
//  final GoogleSignIn _googleSignIn;
  final fb.FirebaseAuth _firebaseAuth;

  FirebaseAuthFacade(
//    this._googleSignIn,
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
    } on fb.FirebaseAuthException catch (e) {
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
    return const Either.left(AuthFailure.featureNotAvailable());
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
      printMessage('Trying email signin: $emailAddressStr\n');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return const Either.right(Coproduct0.empty());
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Either.left(AuthFailure.userNotFound());
      } else if (e.code == 'email-already-in-use') {
        return const Either.left(AuthFailure.emailAlreadyInUse());
      } else if (e.code == 'user-disabled' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        return const Either.left(
            AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return const Either.left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    return Option.some(_firebaseAuth.currentUser!.toDomain());
  }

  @override
  Future<void> signOUt() {
    return Future.wait([
//      _googleSignIn.signOUt(),
      _firebaseAuth.signOut(),
    ]);
  }
}
