import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/main_page.dart';
import 'PetListSelection.dart';

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
  final String imageUrl;

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
    required this.imageUrl,
  });
}

Future<List<Pet>> getPets(String type) async {
  final response = await http.get(Uri.parse(
      'https://demo2-8fd85-default-rtdb.firebaseio.com/${type}_breeds.json'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<Pet> pets = data.map((item) {
      return Pet(
        name: item['breed'],
        breed: item['breed'],
        type: type,
        weight: item['weight'] ?? '',
        food: item['food'] ?? '',
        vaccine: item['vaccine'] ?? '',
        bathRoutine: item['bath_routine'] ?? '',
        lifetime: item['lifetime'] ?? '',
        description: item['description'] ?? '',
        imageUrl: item['image_url'] ?? '',
      );
    }).toList();

    pets.sort((a, b) => a.name.compareTo(b.name));
    return pets;
  } else {
    throw Exception('Failed to load pets');
  }
}

class PetDetails extends StatelessWidget {
  final Pet pet;

  PetDetails({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${pet.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
            Image.network(pet.imageUrl, height: 200, width: 200),
          ],
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;

  PetCard({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
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
          child: Text('View Details'),
        ),
      ),
    );
  }
}

class PetsRecommendations extends StatelessWidget {
  final List<Pet> dogs;
  final List<Pet> cats;

  PetsRecommendations({required this.dogs, required this.cats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet's Recommendations"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                )); // Esto llevará de regreso a la pantalla anterior
          },
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInkWell(context, 'View Dogs', dogs, Colors.blue,
              'assets/images/dog_icon.png', 'Dogs'),
          _buildInkWell(context, 'View Cats', cats, Colors.green,
              'assets/images/cat_icon.png', 'Cats'),
        ],
      ),
    );
  }

  Widget _buildInkWell(BuildContext context, String label, List<Pet> pets,
      Color color, String imagePath, String pageTitle) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PetListSelection(pets: pets, title: pageTitle),
          ),
        );
      },
      child: Card(
        color: color,
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
                imagePath,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetList extends StatelessWidget {
  final List<Pet> pets;

  PetList({required this.pets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet List"),
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("Pet's Recommendations"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/pet_search',
      routes: {
        '/pet_search': (context) {
          return FutureBuilder<List<List<Pet>>>(
            future: Future.wait([getPets('dog'), getPets('cat')]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
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
        },
        '/pet_details': (context) =>
            PetDetails(pet: ModalRoute.of(context)!.settings.arguments as Pet),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
