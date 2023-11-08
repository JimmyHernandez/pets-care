import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserRegistration {

  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;


  UserRegistration(
      this._nameController,
      this._emailController,
      this._passwordController,

      );

  Future<void> registerUser() async {

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // User registration was successful, save user data to Fire store.
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,

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
