import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/my_pets.dart';
import '../functions jimmy/userpicture_input.dart';
User? userid = FirebaseAuth.instance.currentUser;

class PetProfileEdit extends StatefulWidget {
  final String petId;

  const PetProfileEdit(this.petId, {required Key key}) : super(key: key);


  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<PetProfileEdit> {
  // Define controllers for the text fields

  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _treatsController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
   _petNameController.dispose();
   _ageController.dispose();
   _breedController.dispose();
   _weightController.dispose();;
   _foodController.dispose();
   _treatsController.dispose();
   _ownerController.dispose();
   _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String petId = widget.petId;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Pet Profile",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Change this color to the one you prefer
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: 80.0, // Adjust the height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Your bottom navigation items here
              // ...
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            const ImagePickerWidget(),

            TextFormField(
              controller: _petNameController,
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _breedController,
              decoration: const InputDecoration(
                labelText: 'Breed',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _foodController,
              decoration: const InputDecoration(
                labelText: 'Food',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _treatsController,
              decoration: const InputDecoration(
                labelText: 'Treats',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _ownerController,
              decoration: const InputDecoration(
                labelText: 'Pet Owner',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Owner Phone',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),


             // Include your widgets here, such as ImagePickerWidget, TextFormField, and others
            // ...
            ElevatedButton(
              onPressed: () async {

                // Save the edited profile data
                String editedPetName = _petNameController.text;
                String editedAge = _ageController.text;
                String editedBreed = _breedController.text;
                String editedWeight = _weightController.text;
                String editedFood = _foodController.text;
                String editedTreats = _treatsController.text;
                String editedOwner = _ownerController.text;
                String editedPhone = _phoneController.text;

                // Create a map with the data to update in the subcollection document
                Map<String, dynamic> profileUpdates = {
                  'pet_name': editedPetName,
                  'age': editedAge,
                  'breed': editedBreed,
                  'weight': editedWeight,
                  'food': editedFood,
                  'treats': editedTreats,
                  'pet_owner': editedOwner,
                  'owner_phone': editedPhone,
                   // Add other fields to update here
                };

                // Specify the subcollection document ID that you want to update
                String subcollectionDocId =petId;

                // Call the updated updateProfile method to update the subcollection document
                await updateProfile(userid!.uid, subcollectionDocId, profileUpdates);

                // After updating the subcollection document, navigate back to the user profile page

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPets()),
                );
              },
              child: const Text("Save"),
            ),

          ],
        ),
      ),
    );
  }
}

// Function to update the user's profile information in Firestore
Future<void> updateProfile(
    String userId,
    String subcollectionDocId,
    Map<String, dynamic> dataToUpdate,
    ) async {
  try {
    if (subcollectionDocId.isNotEmpty) {
      // Proceed with updating the document only if subcollectionDocId is not empty.
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's main profile document
      DocumentReference userDocRef = firestore.collection('users').doc(userId);

      // Reference to the subcollection document within the user's profile
      DocumentReference subcollectionDocRef =
      userDocRef.collection('pets_profile').doc(subcollectionDocId);

      // Update the subcollection document with the provided data
      await subcollectionDocRef.update(dataToUpdate);

      if (kDebugMode) {
        print('Subcollection document updated successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Subcollection document ID is empty. No update performed.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error updating subcollection document: $e');
    }
  }
}

