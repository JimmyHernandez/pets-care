import 'package:flutter/material.dart';
import '../pages - enyel/PetApp.dart';
import 'buildPetCard.dart';


Widget buildPetList(BuildContext context, List<Pet> pets) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Pet List"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: ListView.builder(
      itemCount: pets.length,
      itemBuilder: (BuildContext context, int index) {
        return buildPetCard(context, pets[index]);
      },
    ),
  );
}
