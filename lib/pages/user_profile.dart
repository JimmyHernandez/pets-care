import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/pets_guidelines.dart';
import 'package:pets_care/pages/user_profile_edit.dart';
import '../pages - enyel/PetApp.dart';
import 'main_page.dart';
import 'my_pets.dart';
User? userid = FirebaseAuth.instance.currentUser;

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getSpecificFieldForCurrentUser() async {
    final User? currentUser = _auth.currentUser;

          if (currentUser == null) {
            return null; // No user is currently logged in
          }
          String? userId = currentUser.uid;
          DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

          if (userDoc.exists) {
            var name = userDoc.get('name'); // Assuming 'name' is the field you want
            if (name != null) {
              return name.toString();
            }
          }
        return null; // If the user's document doesn't exist or 'name' is not present
        }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors
            .white, // Change this color to the one you prefer
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 80.0, // Adjust the height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                tooltip: "Home", // You can change this to any icon you prefer
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                  // Define the action when this icon is pressed
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
                  // Define the action when this icon is pressed
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
                  // Define the action when this icon is pressed
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
                          future: Future.wait([getPets('dog'), getPets('cat')]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                  // Define the action when this icon is pressed
                },
              ),
            ],
          ),
        ),
      ),


      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                // You can load the user's profile picture here
                backgroundImage: NetworkImage(
                    "data:image/png;base64,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"),
              ),
              const SizedBox(height: 16),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                FutureBuilder<String?>(
                  future: getSpecificFieldForCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Display a loading indicator.
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text('${snapshot.data}\n\n  ${userid?.email}', style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24, // Font size
                        fontWeight: FontWeight.bold,
                        // Change the title color to black
                      ),);
                    } else {
                      return const Text('User is not logged in or name is not available.');
                    }
                  },
                ),
              ],
            ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfileEdit()),
                  );
                  // Add an action here, like editing the profile

                },
                child: const Text("Edit Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
