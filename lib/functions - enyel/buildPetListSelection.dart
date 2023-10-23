import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';

class PetListSelection extends StatelessWidget {
  final List<Pet> pets;
  final String title;

  const PetListSelection({super.key, required this.pets, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(
        color: Colors.black, // Change the title color to black
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.black, // Change this color to the one you prefer
      ),
      backgroundColor: Colors
          .white, // Change this color to the one you prefer
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
                  ? const Text("Select a Pet")
                  : const Text("No Pets Available"),
              style: const TextStyle(
                  color: Color.fromARGB(255, 2, 21, 37)), // Personaliza el color del texto
              icon: const Icon(
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
