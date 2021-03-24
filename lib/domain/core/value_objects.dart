import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:notes2/domain/core/errors.dart';
import 'package:notes2/domain/core/failures.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError(f), (r) => r);
  }

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(Either.right(const Uuid().v1()));
  }

  //assuming it will be a unique id. just return correct since not null
  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(Either.right(uniqueId));
  }

  const UniqueId._(this.value);
}
