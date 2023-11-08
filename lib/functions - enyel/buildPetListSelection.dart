import 'package:flutter/material.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';

class PetListSelection extends StatelessWidget {
  final List<Pet> pets;
  final String title;

  const PetListSelection({super.key, required this.pets,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath = title == 'Dogs'
        ? 'assets/images/group_dog.png'
        : 'assets/images/group_cat.jpeg';
    String sectionText = title == 'Dogs'
        ? 'Explore a variety of dog breeds and discover the perfect furry companion for your lifestyle. From energetic and playful to calm and affectionate, find the breed that matches your preferences.\n\nSelect a breed to see usefully information about your dog.'
        : "Discover different cat breeds, each with its own unique personality and characteristics. Select a breed to see usefully information about your cat.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1E6FF),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF6F35A5),
            fontSize: 35, // Set the desired font size
            fontWeight: FontWeight.bold,// Cambia el color del título a negro
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Color(0xFF6F35A5) // Cambia este color a tu preferencia
        ),
      ),

      body:

      Column(
        children: [

          SizedBox(
            height: 340,
            width: double.infinity,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain, // Cambia la propiedad de ajuste aquí
            ),
          ),
          const SizedBox(height: 20),

         Container(
                    width: 450.0,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        sectionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF6F35A5),
                        ),
                      ),
                    ),
                  ),
          const SizedBox(height: 0),

          Center(
            child: DropdownButton<Pet>(
              value: pets.isNotEmpty ? pets[0] : null,
              items: pets.map((Pet pet) {

                return DropdownMenuItem<Pet>(
                  value: pet,
                  child: Center(
                    child: Text(
                      pet.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                color: Color(0xFF6F35A5),
              ),
              icon: const Icon(Icons.search),
              underline: Container(
                height: 2,
                color: const Color(0xFF6F35A5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
