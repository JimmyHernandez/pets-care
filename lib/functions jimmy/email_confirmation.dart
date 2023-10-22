import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      await user?.sendEmailVerification();
      if (kDebugMode) {
        print('Email verification sent!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending email verification: $e');
      }
    }
  }
}
