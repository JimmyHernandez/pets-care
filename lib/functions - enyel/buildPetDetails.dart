import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';

Widget buildPetDetails(Pet pet) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${pet.name}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Breed: ${pet.breed}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Type: ${pet.type}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Weight: ${pet.weight}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Food: ${pet.food}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Vaccine: ${pet.vaccine}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Bath Routine: ${pet.bathRoutine}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Lifetime: ${pet.lifetime}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Description: ${pet.description}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Image.network(
                  pet.imageUrl,
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
