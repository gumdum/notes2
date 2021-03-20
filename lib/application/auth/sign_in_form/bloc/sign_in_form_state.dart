part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState(
      {required EmailAddress emailAddress,
      required Password password,
      required bool showErrorMessages,
      required bool isSubmitting,
      required Option<Either<AuthFailure, Coproduct0>>?
          authFailureorSuccessOption}) = _SignInFormState;
  //have to create an initial state

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        showErrorMessages: true,
        isSubmitting: false,
        authFailureorSuccessOption: None(), //no response yet for the Option
      );
}
