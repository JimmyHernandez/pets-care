import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/welcome/login_page.dart';
import '../../functions - jimmy/email_confirmation.dart';
import '../../functions - jimmy/user_registration.dart';
import '../home_page/homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}
class SignUpScreenState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
  TextEditingController();
  // Define a variable to track if the password matches the confirmation.
  bool _passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Profile'),
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to the one you prefer
        ),
        backgroundColor: Colors.white, // Change this color to the one you prefer
      ),
      body:
      Container(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/PetsCareLogo.png',
              width: 300,
              height: 300,
            ),
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 350) {
                      // Laptop or larger screen size
                      return Container(
                        width: 600,
                        height: 600,
                        padding: const EdgeInsets.all(8),
                        child: Form(
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Full name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xff0849ea),
                                          ),
                                        ),
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your full name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 5),

                                      TextFormField(
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xff0849ea),
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 5),

                                      TextFormField(
                                        obscureText: true,
                                        controller: _passwordController,
                                        decoration: const InputDecoration(

                                          labelText: 'Password',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xff0849ea),

                                          ),
                                        ),
                                        keyboardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 3),

                                      TextFormField(
                                        obscureText: true,
                                        controller: _passwordConfirmationController,
                                        decoration: const InputDecoration(
                                          labelText: 'Password Confirmation',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xff0849ea),
                                          ),
                                        ),
                                      ),
                                      if (!_passwordsMatch)
                                        const Text(
                                          'Passwords do not match!',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      // Add a message to display if passwords don't match.

                                      const SizedBox(height: 8),

                                      ElevatedButton(
                                        onPressed: () async {
                                          // Check if passwords match before proceeding.
                                          if (_passwordController.text !=
                                              _passwordConfirmationController.text) {
                                            setState(() {
                                              _passwordsMatch = false;
                                            });
                                            return; // Passwords don't match, do not proceed.
                                          }

                                          //Send information to UserRegistration class to process sign up

                                          UserRegistration(_nameController,
                                              _emailController,
                                              _passwordController,
                                              _passwordConfirmationController).registerUser();

                                          //Send verification email

                                          EmailVerificationService().sendEmailVerification();

                                          //Navigation to MainScreen after successful login

                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>  const LogInPage(),
                                          ));
                                        },
                                        child: const Text('Sign Up'),

                                      ),const SizedBox(height:10)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Mobile screen size
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0xff0849ea),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              // Add a message to display if passwords don't match.
                              if (!_passwordsMatch)
                                const Text(
                                  'Passwords do not match!',
                                  style: TextStyle(color: Colors.red),
                                ),
                              const SizedBox(height: 16),

                              ElevatedButton(
                                onPressed: () async {
                                  // Check if passwords match before proceeding.
                                  if (_passwordController.text !=
                                      _passwordConfirmationController.text) {
                                    setState(() {
                                      _passwordsMatch = false;
                                    });
                                    return; // Passwords don't match, do not proceed.
                                  }

                                  // Passwords match, you can proceed with the sign-up process.
                                  try {
                                    final userCredential = await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    // Your existing sign-up code...

                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const LogInPage(),
                                    ));
                                  } catch (e) {
                                    // Handle registration errors here.
                                    if (kDebugMode) {
                                      print('Error registering user: $e');
                                    }
                                  }
                                  //Send verification emaill
                                  try {
                                    User? user = FirebaseAuth.instance.currentUser;
                                    await user?.sendEmailVerification();
                                    if (kDebugMode) {
                                      print('Email verification sent!');
                                    }
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('Error sending email verification: $e');
                                    }
                                  }
                                },
                                child: const Text('Sign Up'),
                              ),
                              const SizedBox(height: 16),
                              const SizedBox(height: 32.0, width: 32.0),
                              const Column(
                                children: [
                                  SizedBox(height: 80),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}