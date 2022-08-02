import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser {
  final String id;
  final String email;
  final bool isEmailVerified;
  const AuthUser(
      {required this.isEmailVerified, required this.email, required this.id});
  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email!,
        isEmailVerified: user.emailVerified,
        id: user.uid,
      );
}
