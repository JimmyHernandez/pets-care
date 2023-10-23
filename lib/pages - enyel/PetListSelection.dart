import 'package:flutter/material.dart';

import 'PetApp.dart';


class PetListSelection extends StatelessWidget {
  final List<Pet> pets;
  final String title;

  PetListSelection({required this.pets, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<Pet>(
              value: pets.isNotEmpty
                  ? pets[0]
                  : null, // Asegúrate de tener un valor seleccionado si es necesario
              items: pets.map((Pet pet) {
                return DropdownMenuItem<Pet>(
                  value: pet,
                  child: Text(pet.name),
                );
              }).toList(),
              onChanged: (Pet? pet) {
                if (pet != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetDetails(pet: pet),
                    ),
                  );
                }
              },
              hint: pets.isNotEmpty
                  ? Text("Select a Pet")
                  : Text("No Pets Available"),
              style: TextStyle(
                  color: Color.fromARGB(255, 2, 21, 37)), // Personaliza el color del texto
              icon: Icon(
                  Icons.arrow_downward), // Personaliza el icono de desplegar
              underline: Container(
                // Cambia el color de la línea inferior
                height: 2,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
