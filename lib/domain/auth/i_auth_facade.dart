//called i_auth because it is only an internface
import 'package:dfunc/dfunc.dart';
import 'package:notes2/domain/auth/auth_failure.dart';
import 'package:notes2/domain/auth/user.dart';
import 'package:notes2/domain/auth/value_objects.dart';
import 'package:oxidized/oxidized.dart';

// FirebaseAuth, GoogleSignIn

//this class functions return either a left(failure) or nothing

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();

  Future<Either<AuthFailure, Coproduct0>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Coproduct0>> signinWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  //no parameters required to signin
  Future<Either<AuthFailure, Coproduct0>> signInWithGoogle();
  Future<void> signOUt();
}
