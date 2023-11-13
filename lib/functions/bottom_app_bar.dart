import 'package:flutter/material.dart';
import '../pages/guidelines/pets_guidelines_page.dart';
import '../pages/home_page/homepage.dart';
import '../pages/my_pet_card/my_pets_page.dart';
import '../pages/pet_recommendation/pets_recommendations_page.dart';
import '../pages/user_profile/user_profile_page.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 80.0, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: "Home",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
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
                  MaterialPageRoute(builder: (context) => const PetsGuidelines()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.abc),
              tooltip: "Pet's Recommendations",
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
