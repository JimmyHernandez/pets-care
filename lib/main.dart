import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/firebase_options.dart';
import 'package:pets_care/pages/pet_recommendation/pets_recommendations_page.dart';
import 'package:pets_care/pages/my_pet_card/my_pets_page.dart';
import 'package:pets_care/pages/pets_profile/pets_profile_page.dart';
import 'package:pets_care/pages/guidelines/pets_guidelines_page.dart';
import 'package:pets_care/pages/welcome/introduction_page.dart';
import 'pages/home_page/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      title: "Pet's Care",
      initialRoute: '/',
      routes: {
        '/home': (context) => const MainScreen(),

        /// Home
        '/my_pets': (context) => const MyPets(),

        /// My Pet's
        '/pet_profile': (context) => const PetsProfile(),

        /// Pet's Profile
        '/pet_guidelines': (context) => const PetsGuidelines(),

        /// Pet's Search
        '/pet,s recommendations': (context) =>
            const PetsRecommendations(dogs: [], cats: []),
      },
    );
  }
}
