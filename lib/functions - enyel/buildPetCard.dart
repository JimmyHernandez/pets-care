import 'package:flutter/material.dart';
import '../pages - enyel/PetApp.dart';
import 'buildPetDetails.dart';


Widget buildPetCard(BuildContext context, Pet pet) {
  return Card(
    margin: EdgeInsets.all(10),
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
        child: Text('View Details'),
      ),
    ),
  );
}
