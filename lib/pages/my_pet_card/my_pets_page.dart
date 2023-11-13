import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_care/pages/pets_profile/pets_profile_page.dart';
import '../../functions/delete_pet_profile.dart';
import '../../functions/flip_card.dart';
import '../guidelines/pets_guidelines_page.dart';
import '../home_page/homepage.dart';
import '../pet_recommendation/pets_recommendations_page.dart';
import '../pets_profile/pets_profile_edit_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyPets extends StatelessWidget {
  const MyPets({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class for authenticate and retrieve data from firebase
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;
    CollectionReference<Map<String, dynamic>> collectionRef =
    FirebaseFirestore.instance.collection('users');

    DocumentSnapshot<Map<String, dynamic>> collectionSnapshot =
    await collectionRef.doc(uid).get();

    CollectionReference<Map<String, dynamic>> subcollectionRef =
    collectionSnapshot.reference.collection('pets_profile');

    QuerySnapshot<Map<String, dynamic>> subcollectionData =
    await subcollectionRef.get();

    return subcollectionData.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1E6FF),
        title: const Text("My Pets", style: TextStyle(
          color: Color(0xFF6F35A5),  // Change the title color to black
          // fontFamily: 'YourFontFamily', // Set the desired font family
          fontSize: 35, // Set the desired font size
          fontWeight: FontWeight.bold, // Set the desired font weight
          // You can also use other text style properties like letterSpacing, wordSpacing, etc.
        ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFF6F35A5),  // Change this color to the one you prefer
        ),
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
                tooltip: "My Pets",
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
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter, // Align the FloatingActionButton to the bottom center
        child: Padding(
          padding: const EdgeInsets.all(0), // Adjust the padding values as per your preference
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF6F35A5),
            onPressed: () {
              // You can navigate to a new page or show a dialog to add a new profile
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PetsProfile()),
              );
            },
            tooltip: 'Add New Profile',
            child: const Icon(Icons.add),
          ),
        ),
      ),

      body:
      FutureBuilder(

          future: getData(),
          builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Display an error message if there's an error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Display a message when no data is available
              return const Center(child: Text('No Profile added.'));
            } else {
              // Data is available, let's build the ListView
              List<DocumentSnapshot> data = snapshot.data!;

              return ListView.builder(
                // Create a Card for each document in the sub-collection
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        // Adjust the padding as per your preference
                        child: FlipCardWidget(

                          frontWidget:

                          Container(
                            // Your front content goes here
                            color: const Color(0xFFF1E6FF),
                            width: 600,
                            // Set the width as per your preference
                            height: 350,
                            // Set the height as per your preference
                            alignment: Alignment.center,
                            // Center align the content

                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  bottom:125,
                                  child: Text(data[index]['pet_name'],
                                    style: const TextStyle(
                                      fontSize: 55,
                                      // You can adjust the font size as needed
                                      fontWeight: FontWeight.bold,
                                      // You can change the font weight if desired
                                      color: Color(0xFF6F35A5),
                                      // You can set the text color to your preference
                                      fontFamily: 'Arial', // You can specify the font family
                                      // Other text style properties can be added here
                                    ),
                                    textAlign: TextAlign
                                        .left, // Set the text alignment to center
                                    // Set the text direction (ltr or rtl)
                                  ),
                                ),
                              ],
                            ),
                          ),

                          backWidget: Container(
                            // Your front content goes here
                            color: const Color(0xFFF1E6FF),
                            width: 600,
                            // Set the width as per your preference
                            height: 400,
                            // Set the height as per your preference
                            alignment: Alignment.center,
                            // Center align the content
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 2),
                                  // Left Column with labels
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: " + data[index]['pet_name'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ),
                                      const SizedBox(height: 8),

                                      Text("Age: "+ data[index]['age'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ),
                                      const SizedBox(height: 8),

                                      Text("Breed: "+ data[index]['breed'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ),
                                      const SizedBox(height: 8),
                                      Text("Weight: " + data[index]['weight'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Right Column with data
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Food: " + data[index]['food'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ), const SizedBox(height: 8),

                                      Text("Treats: " + data[index]['treats'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ), const SizedBox(height: 8),

                                      Text("Owner: " + data[index]['pet_owner'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ), const SizedBox(height: 8),

                                      Text("Phone: " + data[index]['owner_phone'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // You can adjust the font size as needed
                                          fontWeight: FontWeight.bold,
                                          // You can change the font weight if desired
                                          color: Color(0xFF6F35A5),
                                          // You can set the text color to your preference
                                          fontFamily: 'Arial', // You can specify the font family
                                          // Other text style properties can be added here
                                        ),
                                        textAlign: TextAlign.center,
                                        // Set the text alignment to center
                                        textDirection: TextDirection
                                            .ltr, // Set the text direction (ltr or rtl)
                                      ), const SizedBox(height: 8),
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Your existing widgets above
                                      Padding(
                                        padding: const EdgeInsets.only(top: 1.0),
                                          child: IconButton(
                                            tooltip: "Edit profile",
                                            icon: const Icon(Icons.edit_document),
                                            onPressed: () {
                                              if (kDebugMode) {
                                                print(data[index]['pet_id']);
                                              }
                                              String petid = data[index]['pet_id'];
                                              if (kDebugMode) {
                                                print(petid);
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PetProfileEdit(petid, key: GlobalKey()),
                                                ),
                                              );
                                              // Add the onPressed logic for the button here
                                            },
                                          ),
                                        ),

                                     Padding(
                                        padding: const EdgeInsets.only(top: 1.0),
                                          child: IconButton(
                                            icon: const Icon(Icons.delete),
                                            tooltip: 'Delete Profile',
                                            onPressed: () async {
                                              bool deleteConfirmed = await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Confirm Deletion'),
                                                    content: const Text('Are you sure you want to delete this profile?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.of(context).pop(false),
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          deleteProfile(data[index].id);
                                                          Navigator.of(context).pop(true);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => const MyPets()),
                                                          );
                                                        },
                                                        child: const Text('Delete'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (deleteConfirmed) {
                                                // Profile deleted, you can update the UI or show a message
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
          }
      ),
    );
  }
}

