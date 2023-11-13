import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../guidelines/pets_guidelines_page.dart';
import '../login/login_screen.dart';
import '../my_pet_card/my_pets_page.dart';
import '../pet_recommendation/pets_recommendations_page.dart';
import '../user_profile/user_profile_page.dart';

User? userId = FirebaseAuth.instance.currentUser;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> getSpecificFieldForCurrentUser() async {
    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return null; // No user is currently logged in
    }
    String? userId = currentUser.uid;
    DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
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
        backgroundColor: const Color(0xFFF1E6FF),
        automaticallyImplyLeading: false,
        title: Center(
          child: FutureBuilder<String?>(
            future: getSpecificFieldForCurrentUser(),
            builder: (context, snapshot) {
              String titleText = 'Welcome';
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                titleText = 'Error: Something went wrong. Please try again.';
              } else if (snapshot.hasData) {
                titleText = 'Hi ${snapshot.data} ';
              } else {
                titleText = 'User is not logged in or name is not available.';
              }
              return Text(
                titleText,
                style: const TextStyle(
                  color: Color(0xFF6F35A5),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        actions: [
          // Configuration icon with caption
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.settings, color: Color(0xFF6F35A5)),
                onPressed: () {
                  // Add your configuration logic here
                  // For example, you can navigate to a settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile()),
                  );
                },
              ),
              const SizedBox(width: 25), // Add some spacing
              ],
          ),
          // Logout button with caption
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.logout, color: Color(0xFF6F35A5)),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
              const SizedBox(width: 25), // Add some spacing
             ],
          ),
        ],
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
                tooltip: 'Home',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.pets),
                tooltip: "My Pets",
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
                    MaterialPageRoute(builder: (context) => const PetsGuidelines()),
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
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.00, -1.00),
                child: Image.asset(
                  'assets/images/main_banner.png',
                  height: 340,
                  fit: BoxFit.fitHeight,
                ),
              ),
              // Image
              // Replace the Image widget with your desired image widget.
              // Guidelines
              const Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 35, 16, 16),
                      child: Text(
                        "Pet's Care",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF6F35A5),
                        ),
                      ),
                    ),
                    // Guidelines Text
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 35),
                      child: Text(
                        "It's a pleasure to have you here and welcome you to our exciting web app for pet lovers. On this platform, you can create a personalized profile\n"
                            "for your pet, where you can store all the important information, from its name and breed to its dietary preferences, among others. Additionally, \n"
                            "our app will provide you with valuable care tips and informative articles to ensure your furry companion is happy and healthy.",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6F35A5),
                        ),
                      ),
                    ),
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
