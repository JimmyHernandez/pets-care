import 'package:flutter/material.dart';
import 'package:pets_care/welcome/login_page.dart';
import 'signup_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/PetsCareLogo.png',
              width: 600, // Adjust the width as needed
              height: 600, // Adjust the height as needed
              fit: BoxFit.contain,
            ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
              "Pet's Care",
              style: TextStyle(
                fontFamily: 'Urbanest',
                color: Color(0xFF101213),
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
        ),
            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome to Pet's Care, a place to keep our best friend in good shape.",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            // Adjust the spacing as needed
            ElevatedButton(

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF101213), backgroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('Get Started'),
            ),
            const SizedBox(height: 16), // Adjust the spacing as needed
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LogInPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF101213), backgroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
