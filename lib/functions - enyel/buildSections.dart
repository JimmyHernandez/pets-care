import 'package:flutter/material.dart';
import '../pages - enyel/PetApp.dart';

List<Widget> buildSections(String title, List<Pet> pets) {
  return [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
