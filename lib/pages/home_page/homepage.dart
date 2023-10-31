import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/guidelines/pets_guidelines_page.dart';
import 'package:pets_care/pages/user_profile/user_profile_page.dart';
import 'package:pets_care/pages/welcome/login_page.dart';
import '../pet_recommendation/pets_recommendations_page.dart';
import '../my_pet_card/my_pets_page.dart';
User? userid = FirebaseAuth.instance.currentUser;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Profile14OtherUserWidgetState createState() =>
      Profile14OtherUserWidgetState();
}

class Profile14OtherUserWidgetState extends State<MainScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> getSpecificFieldForCurrentUser() async {
    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return null; // No user is currently logged in
    }
    String? userId = currentUser.uid;
    DocumentSnapshot userDoc =
    await _db.collection('users').doc(userId).get();

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

                                           // tab "Welcome"
                                           Container(
                                                  width: 300, // Set the width of the container
                                                  padding: const EdgeInsets.all(20), // Add padding for spacing
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black), // Add a border
                                                    borderRadius: BorderRadius.circular(10), // Add rounded corners
                                                  ),

                                                  child: const Column(
                                                    children: <Widget>[
                                                      Text('Welcome', // Your title text
                                                        style: TextStyle(
                                                          fontSize: 27, // Font size
                                                          fontWeight: FontWeight.bold, // Bold style
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(200, 25, 200, 25),
                                                        child: Text(
                                                          "It's a pleasure to have you here and welcome you to our exciting web app for pet lovers. As a software engineering student with a passion for development,\n"
                                                          "you are sure to appreciate the perfect combination of technology and love for animals that we offer. On this platform, you can create a personalized profile\n"
                                                          "for your pet, where you can store all the important information, from its name and breed to its dietary preferences, among others.\n\nAdditionally, our app will\n"
                                                          "provide you with valuable care tips, training tips, and informative articles to ensure your furry companion is happy and healthy. Technology is at the heart of\n"
                                                          "this experience, and we're sure you'll find opportunities to apply and improve your programming skills as you explore all the exciting features we have in store\n"
                                                          "for you.",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                  ],
                                                  )
                                              ),

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
                                                      Text('Our Mission', // Your title text
                                                        style: TextStyle(
                                                          fontSize: 27, // Font size
                                                          fontWeight: FontWeight.bold, // Bold style
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(200, 25, 200, 25),
                                                        child: Text(
                                                          "This web application was created with the idea of helping anyone who has a pet or wants to have one to have access to useful information to maintain a\n"
                                                              "healthy pet for the well-being of all of us. Having healthy pets helps us, their owners, have better health and quality of life. If it is true that our\n"
                                                              "pets help us a lot as emotional support and that it is a significant relief in our lives, it is also true that without proper care, our pet could suffer\n"
                                                              "from different diseases that are transmitted to us humans.\n\n"

                                                              "Diseases such as Rabies, Parvo virus, Leptospirosis, Scabies and several instestinal parasites that affect their health and ours too. This is why here you can find\n"
                                                              "information for your pet, this information is designed to be short and precise and easy to understand. You will find specific information for a particular\n"
                                                              "breed such as the recommended food, its ideal weight, life expectancy, among others. We also have general help guides for pets classified as mixed. This space\n"
                                                              "is for everyone, as part of the development process at the moment we only have two species of pets: dogs and cats. Thank you for being part of the change\n"
                                                              "to have a better quality of life with our pet.",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

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
                                                  child:  const Center(

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[

                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 25, 0),// You can adjust the padding as needed
                                                          child: Card(
                                                            child: Column(
                                                              children: <Widget>[
                                                                CircleAvatar(
                                                                  backgroundImage: AssetImage('assets/images/jimmy.png'), // Replace with the path to your image
                                                                  radius: 75, // Adjust the size of the profile picture
                                                                ),
                                                                SizedBox(height: 25),
                                                                Text(
                                                                  'Jimmy Hernandez Rivera',
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                Text(
                                                                  "Full-Stack Software Engineer | Bilingual: Spanish & English",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                Text(
                                                                      "I am a dynamic person, eager to learn. I have had the opportunity to\n"
                                                                      "develop my programming skills thanks to Holberton's intensive course,\n"
                                                                      "definitely a decision that marked a significant change in my life and\n"
                                                                      "can be reflected in this project that we carry out with a lot of love\n"
                                                                      "and respect for our pets. I dedicate this project to my family, specif\n"
                                                                      "ically to my twin sister, who inspired me to make this web application\n "
                                                                      "after graduating as a Veterinary Assistant. I love animals, my pet is a\n"
                                                                      "Gold Retriever named Max and he was my grandfather's companion. After my\n"
                                                                      "grandfather left this world, I stayed with Max and he has filled me with a\n"
                                                                      "lot of happiness in difficult times, enough inspiration to continue dev\n"
                                                                      "eloping this website for the benefit of all our pets and, in turn, ourselves.",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                  ),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                                SizedBox(height: 2),
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
                                                                  backgroundImage: AssetImage('assets/images/enyel.png'), // Replace with the path to your image
                                                                  radius: 75, // Adjust the size of the profile picture
                                                                ),
                                                                SizedBox(height: 25),
                                                                Text(
                                                                  'Enyel Feliz Mercado',
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                Text(
                                                                  "Full-Stack Software Engineer | Bilingual: Spanish & English",
                                                                    style: TextStyle(
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                Text( "A passionate Full-Stack Software Engineer with experience in developing\n"
                                                                      "both client-side and server-side applications. He is committed to technical\n"
                                                                      "excellence and possesses a creative mindset to address complex challenges.\n"
                                                                      "His dedication and passion for technology make him an exceptional professional\n"
                                                                      "in the field of software engineering.",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                  ),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                                SizedBox(height: 2),
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
