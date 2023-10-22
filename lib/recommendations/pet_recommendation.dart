import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../pages/main_page.dart';

class Pet {
  final String name;
  final String breed;
  final String type;
  final String weight;
  final String food;
  final String vaccine;
  final String bathRoutine;
  final String lifetime;
  final String description;
  final String imagePath; // Ruta de la imagen

  Pet({
    required this.name,
    required this.breed,
    required this.type,
    required this.weight,
    required this.food,
    required this.vaccine,
    required this.bathRoutine,
    required this.lifetime,
    required this.description,
    required this.imagePath, // Incluye la nueva propiedad
  });
}

Future<String> getImageUrl(String imagePath) async {
  Reference ref = FirebaseStorage.instance.refFromURL(imagePath);
  return await ref.getDownloadURL();
}

Future<List<Pet>> getPets(String type) async {
  final response = await http.get(
    Uri.parse(
        'https://demo2-8fd85-default-rtdb.firebaseio.com/${type}_breeds.json'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<Pet> pets = [];
    for (var item in data) {
      Pet pet = Pet(
        name: item['breed'],
        breed: item['breed'],
        type: type,
        weight: item['weight'] ?? '',
        food: item['food'] ?? '',
        vaccine: item['vaccine'] ?? '',
        bathRoutine: item['bath_routine'] ?? '',
        lifetime: item['lifetime'] ?? '',
        description: item['description'] ?? '',
        imagePath: item['image_path'] ?? '', // Asigna la ruta de la imagen
      );
      pets.add(pet);
    }
    pets.sort((a, b) => a.name.compareTo(b.name)); // Ordena alfabéticamente
    return pets;
  } else {
    throw Exception('Failed to load pets');
  }
}

class PetDetails extends StatelessWidget {
  final Pet pet;

  const PetDetails({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${pet.name}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Breed: ${pet.breed}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Type: ${pet.type}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Weight: ${pet.weight}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Food: ${pet.food}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Vaccine: ${pet.vaccine}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Bath Routine: ${pet.bathRoutine}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Lifetime: ${pet.lifetime}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Description: ${pet.description}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: getImageUrl(pet.imagePath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Image.network(
                    snapshot.data!, // URL de la imagen
                    height: 200, // Ajusta el tamaño según sea necesario
                    width: 200,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(const MyApp());
}


class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(pet.name),
        subtitle: Text('Breed: ${pet.breed}, Type: ${pet.type}'),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetDetails(pet: pet),
              ),
            );
          },
          child: const Text('View Details'),
        ),
      ),
    );
  }
}

class PetsRecommendations extends StatelessWidget {
  final List<Pet> dogs;
  final List<Pet> cats;

  const PetsRecommendations({super.key, required this.dogs, required this.cats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Recommendations"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetList(pets: dogs),
                ),
              );
            },
            child: Card(
              color: const Color.fromARGB(255, 80, 49, 219),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: 250,
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/dog_icon.png', // Ajusta la ruta de la imagen
                        height: 100,
                        width: 100), // Ajusta el tamaño de la imagen
                    const SizedBox(height: 10),
                    const Text(
                      'View Dogs',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetList(pets: cats),
                ),
              );
            },
            child: Card(
              color: const Color.fromARGB(255, 15, 136, 143),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: 250,
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/cat_icon.png', // Ajusta la ruta de la imagen
                        height: 100,
                        width: 100), // Ajusta el tamaño de la imagen
                    const SizedBox(height: 10),
                    const Text(
                      'View Cats',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetList extends StatelessWidget {
  final List<Pet> pets;

  const PetList({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet List"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (BuildContext context, int index) {


          return PetCard(pet: pets[index]);


        },
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  get cats => null;

  get dogs => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          // ... (otros elementos del drawer)

          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("Pet's Recommendations"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {

                    return PetsRecommendations(
                      dogs: dogs,
                      cats: cats,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildSection(String title, List<Pet> pets) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),


      ListView.builder(
        shrinkWrap: true,
        itemCount: pets.length,
        itemBuilder: (BuildContext context, int index) {
          return PetCard(pet: pets[index]);
        },
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
            return FutureBuilder<List<List<Pet>>>(
            future: Future.wait([getPets('dog'), getPets('cat')]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Pet> dogs = snapshot.data![0];
                List<Pet> cats = snapshot.data![1];
                return PetsRecommendations(
                  dogs: dogs,
                  cats: cats,
                );
              }
            },
          );
        }
      }
