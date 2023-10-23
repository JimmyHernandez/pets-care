import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';
import 'buildPetDetails.dart';

Widget buildPetCard(BuildContext context, Pet pet) {
  return Card(
    margin: const EdgeInsets.all(10),
    child: ListTile(
      title: Text(pet.name),
      subtitle: Text('Breed: ${pet.breed}, Type: ${pet.type}'),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => buildPetDetails(pet),
            ),
          );
        },
        child: const Text('View Details'),
      ),
    ),
  );
}
