import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/pets_guidelines.dart';
import 'package:pets_care/pages/user_profile_edit.dart';
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
                    "https://example.com/profile_image.jpg"),
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
