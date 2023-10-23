import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  PasswordResetPageState createState() => PasswordResetPageState();
}

class PasswordResetPageState extends State<PasswordResetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String _resetMessage = '';

  Future<void> _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );
        setState(() {
          _resetMessage = 'Password reset email sent successfully!';
        });
      } catch (e) {
        setState(() {
          _resetMessage = 'Error sending password reset email: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
          iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to the one you prefer
                     ),
        backgroundColor: Colors.white, // Change this color to the one you prefer
      ),
      body:  SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(125),
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Image.asset(
                  'assets/images/PetsCareLogo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 16),

                const Text(
                  "Lost your password? Please enter your email address. You will receive a link to create a new password via email.",
                  style: TextStyle(
                    fontSize: 19.0,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                Center(
                  child: SizedBox(
                    width: 350.0, // Adjust the width as needed for medium size
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email',
                        icon: Icon(Icons.lock_reset, color: Colors.blue)),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _sendPasswordResetEmail,
                  child: const Text('Reset Password'),
                ),
                const SizedBox(height: 16.0),

                Text(_resetMessage, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}