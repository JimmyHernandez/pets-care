import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:pets_care/welcome/signup_page.dart';
import '../pages/main_page.dart';
import '../pages/forgot_password.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  final logger = Logger();
  late ScaffoldMessengerState _scaffoldMessengerState;

  void _navigateToHomePage(User? user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  const MainScreen(),
      ),
    );
  }

  Future<void> _logInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final user = userCredential.user;
      _navigateToHomePage(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showErrorMessage('The email address is badly formatted.');
        logger.e('Error message: ${e.message}');
      }else if (e.code == 'user-not-found') {
        showErrorMessage('The user does not exist.');
        logger.e('Error message: ${e.message}');
      }else if (e.code == 'wrong-password') {
        showErrorMessage('The password is incorrect.');
        logger.e('Error message: ${e.message}');
      }else {
        showErrorMessage('Failed to Log in');
        logger.e('Error message: ${e.message}');
      }

    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorMessage(String message) {
    _scaffoldMessengerState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xff0849ea),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessengerState = ScaffoldMessenger.of(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/PetsCareLogo.png',
              width: 300,
              height: 300,
            ),
            Expanded(
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 350) {
                      // Laptop or larger screen size
                      return Container(
                        width: 400,
                        height: 400,
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
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
                                      const SizedBox(height: 30),

                                      TextFormField(
                                        controller: _passwordController,
                                        decoration: const InputDecoration(
                                          labelText: 'Password',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xff0849ea),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                      ),const SizedBox(height: 30),

                                      Column(
                                        children: [
                                          // Sign Up and Forgot Password Buttons
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  // Implement sign-up logic here
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const SignUpPage(),
                                                    ),
                                                  );
                                                },
                                                child: const Text('Sign Up'),
                                              ),

                                              TextButton(
                                                onPressed: () {
                                                  // Implement forgot password logic here
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const PasswordResetPage(),
                                                    ),
                                                  );
                                                },
                                                child: const Text('Forgot Password?'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Material(
                                    color: const Color(0xff0849ea),
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      onTap: () {
                                        _logInWithEmailAndPassword();
                                      },
                                      child: Container(

                                        padding: const EdgeInsets.symmetric(
                                            vertical: 35, horizontal: 60),
                                        child: const Text(
                                          "Log in",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
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
                          key: _formKey,
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
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0xff0849ea),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32.0, width: 32.0),
                              Column(
                                children: [
                                  const SizedBox(height: 80),
                                  Material(
                                    color: const Color(0xff0849ea),
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      onTap: () {
                                        _logInWithEmailAndPassword();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 50),
                                        child: const Text(
                                          "Log In",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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