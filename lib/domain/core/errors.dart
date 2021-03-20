import 'package:notes2/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() =>
      Error.safeToString('Terminating: Failure: $valueFailure');
}
