import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/guidelines/vaccine_guide.dart';
import 'package:pets_care/pages/guidelines/vaccine_pets.dart';
import 'package:pets_care/pages/user_profile/user_profile_page.dart';
import 'package:pets_care/pages/welcome/login_page.dart';
import '../pet_recommendation/pets_recommendations_page.dart';
import '../home_page/homepage.dart';
import '../my_pet_card/my_pets_page.dart';
import 'bath_pet.dart';
import 'excercises_pet.dart';
import 'feed_pet.dart';

class PetsGuidelines extends StatefulWidget {
  const PetsGuidelines({Key? key}) : super(key: key);

  @override
  GuidelinesLayoutWidgetState createState() =>
      GuidelinesLayoutWidgetState();
}

class GuidelinesLayoutWidgetState
    extends State<PetsGuidelines> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pet's Guidelines",
            style: TextStyle(
              color: Colors.black, // Change the title color to black
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white, // Chan
          // Change this color to the one you prefer
          actions: [const SizedBox(width: 1),
            // logout button
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black), // Set the icon color to blue
              tooltip: 'Logout',
              color: Colors.black, // Set the button's text color to white
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
            )
          ],
        ),
        bottomNavigationBar:
        BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 80.0, // Adjust the height as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home),
                  tooltip: "Home",// You can change this to any icon you prefer
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  const MainScreen()),
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
                      MaterialPageRoute(builder: (context) =>  const MyPets()),
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
                      MaterialPageRoute(builder: (context) => const PetsGuidelines()),
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
                    // Define the action when this icon is pressed
                  },
                ),
              ],
            ),
          ),
        ),
        key: scaffoldKey,
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
                    'assets/images/guidelines.png',  // Replace with the actual path to your asset image.
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
                          'Guidelines',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Guidelines Text
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 35),
                        child: Text(
                          "Here you'll find general guidelines for pets care, general information for good care of our friend.",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Example item
                buildListItem('The correct way to feed my pet'),
                buildListItem('Bath routine'),
                buildListItem('Recommended vaccines'),
                buildListItem('Exercise'),
                buildListItem('Vaccine guide'),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildListItem(String text) {
    return Padding(                  //left/top/right/bottom
      padding: const EdgeInsets.fromLTRB(200, 5, 200, 15),
      child: InkWell(
        onTap: () {
          // Perform actions based on the tapped item
          if (text == 'The correct way to feed my pet') {
            // Handle the first item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedPet()),
            );

          } else if (text == 'Bath routine') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BathPet()),
            );
            // Handle the second item
          } else if (text == 'Recommended vaccines') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VaccinePet()),
            );
            // Handle the third item
          } else if (text == 'Exercise') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExercisePet()),
            );
            // Handle the fourth item
          }

          else if (text == 'Vaccine guide') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VaccineGuide()),
            );
            // Handle the fourth item
          }

         // Handle item click
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1F4F8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x33000000),
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
