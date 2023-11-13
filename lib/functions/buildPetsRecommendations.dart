import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';

Widget buildPetsRecommendations(
    BuildContext context, List<Pet> dogs, List<Pet> cats) {
  return Scaffold(
      body: ListView(
      children: [
        InkWell(
          child: Card(
            color: const Color.fromARGB(255, 80, 49, 219),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 250,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/dog_icon.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'View Dogs',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(

          child: Card(
            color: const Color.fromARGB(255, 15, 136, 143),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 250,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/cat_icon.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'View Cats',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
