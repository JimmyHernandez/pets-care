import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../home_page/homepage.dart';
import '../my_pet_card/my_pets_page.dart';
import '../guidelines/pets_guidelines_page.dart';
import '../user_profile/user_profile_page.dart';
import '../../functions - enyel/buildPetListSelection.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
      'https://petsweb-390e8-default-rtdb.firebaseio.com/${type}_breeds.json'));

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
        imageUrl: item['image_path'] ?? '',
              );
    }).toList();
    pets.sort((a, b) => a.name.compareTo(b.name));
    return pets;
  } else {
    throw Exception('Failed to load pets');
  }
}

Future<String> getImageUrl(String imagePath) async {
  try {
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(imagePath);
    final url = await ref.getDownloadURL();

    if (kDebugMode) {
      print(url);
    }
    return url;

  } catch (e) {

    if (kDebugMode) {
      print('Error getting image URL: $e');
    }
    return ''; // Devuelve una URL de imagen por defecto o maneja el error según sea necesario
  }
}

class PetDetails extends StatelessWidget {
  final Pet pet;

  const PetDetails({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pet Detail",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to the one you prefer
        ),
        backgroundColor:
            Colors.white, // Change this color to the one you prefer
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      pet.imageUrl,
                      height: 400,
                      width: 400,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Text('Failed to load image');
                      },
                    ),
                    const SizedBox(height: 5),
                    Text(
                      pet.name,
                      style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text('Breed: ${pet.breed}\n', style: const TextStyle(fontSize: 16)),
                    Text('Type: ${pet.type}\n', style: const TextStyle(fontSize: 16)),
                    Text('Weight: ${pet.weight}\n',
                        style: const TextStyle(fontSize: 16)),
                    Text('Food: ${pet.food}\n', style: const TextStyle(fontSize: 16)),
                    Text('Vaccine: ${pet.vaccine}\n',
                        style: const TextStyle(fontSize: 16)),
                    Text('Bath Routine: ${pet.bathRoutine}\n',
                        style: const TextStyle(fontSize: 16)),
                    Text('Lifetime: ${pet.lifetime}\n',
                        style: const TextStyle(fontSize: 16)),
                    Text('Description: ${pet.description}\n',
                        style: const TextStyle(fontSize: 16)),
                    Text('image_path: ${pet.imageUrl}\n',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pet's Recommendations",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home),
                  tooltip: "Home",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.pets),
                  tooltip: "My Pet's",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyPets()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.recommend),
                  tooltip: "Pet's Guidelines",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PetsGuidelines()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.abc),
                  tooltip: ("Pet's Recommendations"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FutureBuilder<List<List<Pet>>>(
                            future:
                                Future.wait([getPets('dog'), getPets('cat')]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  tooltip: "Edit Profile",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfile()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Vertically center the content
                  children: [
                    SizedBox(height: 140),
                    Text(
                      "Welcome to Pet's Recommendations Section!",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Here you can choose your favorite pet to see specific recommendations by breed and get more important information about your pet.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 105),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    _buildInkWell(context, 'View Dogs', dogs, Colors.blue,
                        'assets/images/dog_icon.png', 'Dogs'),
                    const SizedBox(height: 10),
                    const Text(
                      'Explore our curated list of dog breeds.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildInkWell(context, 'View Cats', cats, Colors.green,
                        'assets/images/cat_icon.png', 'Cats'),
                    const SizedBox(height: 10),
                    const Text(
                      'Discover various cat breeds and their characteristics.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInkWell(BuildContext context, String label, List<Pet> pets,
    Color color, String imagePath, String pageTitle) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PetListSelection(pets: pets, title: pageTitle),
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
              style: const TextStyle(
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

class PetList extends StatelessWidget {
  final List<Pet> pets;

  const PetList({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pet's List",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to the one you prefer
        ),
        backgroundColor:
            Colors.white, // Change this color to the one you prefer
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
  const MyApp({super.key});

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
        },
        '/pet_details': (context) =>
            PetDetails(pet: ModalRoute.of(context)!.settings.arguments as Pet),
      },
    );
  }
}
