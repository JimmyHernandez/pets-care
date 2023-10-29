import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';

class PetListSelection extends StatelessWidget {
  final List<Pet> pets;
  final String title;

  const PetListSelection({
    Key? key,
    required this.pets,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath = title == 'Dogs'
        ? 'assets/images/group_dog.png'
        : 'assets/images/group_cat.jpeg';
    String sectionText = title == 'Dogs'
        ? 'Explore a variety of dog breeds and discover the perfect furry companion for your lifestyle. From energetic and playful to calm and affectionate, find the breed that matches your preferences.'
        : "If you're a cat lover, dive into a world of feline friends. Discover different cat breeds, each with its own unique personality and characteristics. Whether you're looking for an independent companion or a social snuggler, you're sure to find the perfect match.";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black, // Cambia el color del título a negro
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // Cambia este color a tu preferencia
        ),
        backgroundColor: Colors.white, // Cambia este color a tu preferencia
      ),
      body: Column(
        children: [
          Container(
            height: 340,
            width: double.infinity,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain, // Cambia la propiedad de ajuste aquí
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Select a breed to explore recommendations.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors
                  .black, // Cambia el color del texto según tus preferencias
            ),
          ),
          SizedBox(height: 20),
          Text(
            sectionText, // Reemplaza '.' con 'sectionText'
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          DropdownButton<Pet>(
            value: pets.isNotEmpty ? pets[0] : null,
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
              color: Color.fromARGB(255, 2, 21, 37),
            ),
            icon: const Icon(Icons.arrow_downward),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
