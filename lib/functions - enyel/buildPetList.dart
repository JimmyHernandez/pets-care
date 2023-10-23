import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';
import 'buildPetCard.dart';

Widget buildPetList(BuildContext context, List<Pet> pets) {
  return Scaffold(
      body: ListView.builder(
      itemCount: pets.length,
      itemBuilder: (BuildContext context, int index) {
        return buildPetCard(context, pets[index]);
      },
    ),
  );
}
