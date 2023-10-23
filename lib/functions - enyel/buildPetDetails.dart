import 'package:flutter/material.dart';

import '../pages - enyel/PetApp.dart';


Widget buildPetDetails(Pet pet) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Pet Details'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${pet.name}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Breed: ${pet.breed}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Type: ${pet.type}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Weight: ${pet.weight}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Food: ${pet.food}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Vaccine: ${pet.vaccine}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Bath Routine: ${pet.bathRoutine}',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Lifetime: ${pet.lifetime}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Description: ${pet.description}',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Image.network(
            pet.imageUrl,
            height: 200,
            width: 200,
          ),
        ],
      ),
    ),
  );
}
