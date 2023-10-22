import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/pets_guidelines.dart';
import 'package:pets_care/pages/user_profile.dart';
import '../welcome/login_page.dart';
import 'my_pets.dart';
User? userid = FirebaseAuth.instance.currentUser;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _Profile14OtherUserWidgetState createState() =>
      _Profile14OtherUserWidgetState();
}

class _Profile14OtherUserWidgetState extends State<MainScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

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
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: FutureBuilder<String?>(
            future: getSpecificFieldForCurrentUser(),
            builder: (context, snapshot) {
              String titleText = 'Welcome';
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                titleText = 'Error: ${snapshot.error}';
              } else if (snapshot.hasData) {
                titleText = 'Welcome, ${snapshot.data}';
              } else {
                titleText = 'User is not logged in or name is not available.';
              }
              return Text(
                titleText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Logout',
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
                tooltip: 'Home',// You can change this to any icon you prefer
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
                icon: const Icon(Icons.person),
                tooltip: "Edit Profile",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  UserProfile()),
                  );
                  // Define the action when this icon is pressed
                },
              ),
            ],
          ),
        ),
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: const AlignmentDirectional(0, -1),
          children: [
            Align(
              alignment: const AlignmentDirectional(0.00, -1.00),
              child: Image.asset(
                'assets/images/main_banner.png',  // Replace with the actual path to your asset image.
                height: 340,
                fit: BoxFit.fitHeight,
               ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.00, 1.00),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 800,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x320E151B),
                                offset: Offset(0, -2),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, 0),
                                          child: TabBar(
                                            labelColor: const Color(0xFF0F1113),
                                            unselectedLabelColor: const Color(0xFF57636C),
                                            tabs: const [
                                              Tab(text: 'Welcome'),
                                              Tab(text: 'Our Mission'),
                                              Tab(text: 'Our Team'),
                                            ],
                                            controller: tabController,
                                          ),
                                        ),
                                        Expanded(

                                          child: TabBarView(

                                            controller: tabController,
                                            children: [

                                              //tab "Welcome"

                                              Container(

                                                  width: 300, // Set the width of the container
                                                  padding: const EdgeInsets.all(20), // Add padding for spacing
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black), // Add a border
                                                    borderRadius: BorderRadius.circular(10), // Add rounded corners
                                                  ),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Welcome', // Your title text
                                                        style: TextStyle(
                                                          fontSize: 24, // Font size
                                                          fontWeight: FontWeight.bold, // Bold style
                                                        ),
                                                      ),
                                                      SizedBox(height: 10), // Add some space between title and description
                                                      Text(
                                                        "This web application", // Your description text
                                                        style: TextStyle(
                                                          fontSize: 16, // Font size
                                                        ),
                                                      ),
                                                    ],
                                                  )


                                              ),

                                              // Add your content here

                                              // tab "Our Mission"
                                           Container(
                                                  width: 300, // Set the width of the container
                                                  padding: const EdgeInsets.all(20), // Add padding for spacing
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black), // Add a border
                                                    borderRadius: BorderRadius.circular(10), // Add rounded corners
                                                  ),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Our Mission', // Your title text
                                                        style: TextStyle(
                                                          fontSize: 24, // Font size
                                                          fontWeight: FontWeight.bold, // Bold style
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(75, 25, 75, 25),
                                                        child: Text( "This web application was created with the idea of helping anyone who has a pet or wants to have one to have access to useful information to maintain a healthy pet for the well-being of all of us."
                                                            " Having healthy pets helps us, their owners, have better health and quality of life. If it is true that our pets help us a lot as emotional support and that it is a significant relief in our lives,"
                                                            " it is also true that without proper care, our pet could suffer from different diseases that are transmitted to us humans.""\n\nDiseases such as Rabies, Toxoplasmosis, Leptospirosis, Scabies and "
                                                            " respiratory diseases can significantly affect our health. This is why here you can find information for your pet, this information is designed to be short and precise and easy to understand."
                                                            " You will find specific information for a particular breed such as the recommended food, its ideal weight, life expectancy, among others. We also have general help guides for pets classified as mixed."
                                                            " This space is for everyone, as part of the development process at the moment we only have two species of pets: dogs and cats. Thank you for being part of the change to have a better quality of life"
                                                            " with our pet.", // Your description text
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      // Add some space between title and description
                                                    ],
                                                  )
                                              ),

                                             // tab "OUR TEAM"
                                              Container(
                                                  width: 300, // Set the width of the container
                                                  padding: const EdgeInsets.all(20), // Add padding for spacing
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black), // Add a border
                                                    borderRadius: BorderRadius.circular(10), // Add rounded corners
                                                  ),
                                                  child: const Center(

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[

                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 25, 0),// You can adjust the padding as needed
                                                          child: Card(
                                                            child: Column(
                                                              children: <Widget>[
                                                                CircleAvatar(
                                                                  backgroundImage: AssetImage('images/jimmy.png'), // Replace with the path to your image
                                                                  radius: 100, // Adjust the size of the profile picture
                                                                ),
                                                                Text(
                                                                  'Jimmy Hernandez Rivera',
                                                                  style: TextStyle(
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 10),

                                                                Text(
                                                                  "Full-Stack Software Engineer | Bilingual: Spanish & English",

                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 25, 0),// You can adjust the padding as needed
                                                          child: Card(
                                                            child: Column(
                                                              children: <Widget>[
                                                                CircleAvatar(
                                                                  backgroundImage: AssetImage('images/enyel.png'), // Replace with the path to your image
                                                                  radius: 100, // Adjust the size of the profile picture
                                                                ),
                                                                Text(
                                                                  'Enyel Feliz Mercado',
                                                                  style: TextStyle(
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 10),
                                                                Text(
                                                                  "Full-Stack Software Engineer | Bilingual: Spanish & English",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}