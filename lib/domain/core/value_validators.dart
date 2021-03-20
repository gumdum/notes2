import 'package:dfunc/dfunc.dart';

import 'package:notes2/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(input)) {
    return Either.right(input);
  } else {
    return Either.left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return Either.right(input);
  } else {
    return Either.left(ValueFailure.shortPassword(failedValue: input));
  }
}
