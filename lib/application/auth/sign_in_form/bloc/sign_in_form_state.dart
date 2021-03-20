part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState(
          EmailAddress emailAddres,
          Password password,
          bool showErrorMessages,
          bool isSubmitting,
          Option<Either<AuthFailure, Coproduct0>> authFailureorSuccessOption) =
      _SignInFormState;
  //have to create an initial state
  factory SignInFormState.initial() => SignInFormState(
        EmailAddress(''),
        Password(''),
        true,
        false,
        None(), //no response yet for the Option
      );
}
