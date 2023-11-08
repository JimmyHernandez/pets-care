import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../pages/home_page/homepage.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
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
        builder: (context) => const MainScreen(),
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
      } else if (e.code == 'user-not-found') {
        showErrorMessage('The user does not exist.');
        logger.e('Error message: ${e.message}');
      } else if (e.code == 'wrong-password') {
        showErrorMessage('The password is incorrect.');
        logger.e('Error message: ${e.message}');
      } else {
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
    return Form(
      key: _formKey, // Added the key property
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: _logInWithEmailAndPassword, // Added the onPressed property
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
