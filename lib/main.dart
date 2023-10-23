import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages%20-%20enyel/PetApp.dart';
import 'package:pets_care/pages/my_pets.dart';
import 'package:pets_care/pages/pets_profile.dart';
import 'package:pets_care/pages/pets_guidelines.dart';
import 'package:pets_care/welcome/introduction.dart';
import 'firebase/firebase_options.dart';
import 'pages/main_page.dart';

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
        '/home': (context) => const MainScreen(), /// Home
        '/my_pets': (context) => const MyPets(), /// My Pet's
        '/pet_profile': (context) => const PetsProfile(), /// Pet's Profile
        '/pet_guidelines': (context) => const PetsGuidelines(),  /// Pet's Search
        '/pet,s recommendations': (context) => PetsRecommendations(dogs: [], cats: []),
      },
    );
  }
}
