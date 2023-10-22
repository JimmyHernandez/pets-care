import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserRegistration {

  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _passwordConfirmationController;

  UserRegistration(
      this._nameController,
      this._emailController,
      this._passwordController,
      this._passwordConfirmationController,
      );

  Future<void> registerUser() async {
    if (_passwordController.text != _passwordConfirmationController.text) {
      // Passwords don't match, do not proceed.
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // User registration was successful, save user data to Firestore.
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'passwordConfirmation': _passwordConfirmationController.text,

          // Add other user data fields as needed
        });

        // You can navigate to the next screen or perform other actions here.
        if (kDebugMode) {
          print('User registered: ${userCredential.user?.email}');
        }
      }
    } catch (e) {
      // Handle registration errors here.
      if (kDebugMode) {
        print('Error registering user: $e');
      }
    }
  }
}
