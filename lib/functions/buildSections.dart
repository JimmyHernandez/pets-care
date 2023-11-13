import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';

List<Widget> buildSections(String title, List<Pet> pets) {
  return [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 5, fontWeight: FontWeight.bold),
      ),
    ),
    ListView.builder(
      shrinkWrap: true,
      itemCount: pets.length,
      itemBuilder: (BuildContext context, int index) {
        return PetCard(pet: pets[index]);
      },
    ),
  ];
}
