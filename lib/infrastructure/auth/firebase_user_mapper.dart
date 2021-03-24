import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:notes2/domain/auth/user.dart';
import 'package:notes2/domain/core/value_objects.dart';

extension FirebaseUserDomainX on fb.User {
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
