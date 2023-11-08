import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/my_pet_card/my_pets_page.dart';
import '../../functions - jimmy/petspicture_input.dart';
User? userid = FirebaseAuth.instance.currentUser;

class PetProfileEdit extends StatefulWidget {
  final String petId;
  const PetProfileEdit(this.petId, {required Key key}) : super(key: key);
  @override
  UserProfileEditState createState() => UserProfileEditState();
}

class UserProfileEditState extends State<PetProfileEdit> {
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
          backgroundColor: const Color(0xFFF1E6FF),
        title: const Text("Edit Pet's Profile",

          style: TextStyle(
            color: Color(0xFF6F35A5),
            fontSize: 35, // Set the desired font size
            fontWeight: FontWeight.bold, // Set the desired font weight// Change the title color to black
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Color(0xFF6F35A5),
          // Change this color to the one you prefer
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 350) {
                      return Container(
                        width: 600,
                        height: 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Form(
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [

                                      TextFormField(
                                        controller: _petNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Pet name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Pet name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _breedController,
                                        decoration: const InputDecoration(
                                          labelText: 'Breed',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter breed';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _ageController,
                                        decoration: const InputDecoration(
                                          labelText: 'Age',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter age';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _weightController,
                                        decoration: const InputDecoration(
                                          labelText: 'Weigh',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter weigh';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _foodController,
                                        decoration: const InputDecoration(

                                          labelText: 'Food',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter food';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _treatsController,
                                        decoration: const InputDecoration(
                                          labelText: 'Treats',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _ownerController,
                                        decoration: const InputDecoration(
                                          labelText: 'Owner',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _phoneController,
                                        decoration: const InputDecoration(
                                          labelText: 'Phone Owner',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 25),
                                      // ... Other TextFormField widgets ...

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
                                          Map<String, dynamic> profileUpdates = {};

                                          if (editedPetName.isNotEmpty) {
                                            profileUpdates['pet_name'] = editedPetName;
                                          }
                                          if (editedAge.isNotEmpty) {
                                            profileUpdates['age'] = editedAge;
                                          }
                                          if (editedBreed.isNotEmpty) {
                                            profileUpdates['breed'] = editedBreed;
                                          }
                                          if (editedWeight.isNotEmpty) {
                                            profileUpdates['weight'] = editedWeight;
                                          }
                                          if (editedFood.isNotEmpty) {
                                            profileUpdates['food'] = editedFood;
                                          }
                                          if (editedTreats.isNotEmpty) {
                                            profileUpdates['treats'] = editedTreats;
                                          }
                                          if (editedOwner.isNotEmpty) {
                                            profileUpdates['pet_owner'] = editedOwner;
                                          }
                                          if (editedPhone.isNotEmpty) {
                                            profileUpdates['owner_phone'] = editedPhone;
                                          }

                                          // Specify the sub collection document ID that you want to update
                                          String collectionDocId = petId;

                                          // Call the updated updateProfile method to update the sub collection document
                                          await updateProfile(userid!.uid, collectionDocId, profileUpdates);

                                          // After updating the sub collection document, navigate back to the user profile page
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => const MyPets()),
                                          );
                                        },   style: ElevatedButton.styleFrom(
                                             backgroundColor: const Color(0xFF6F35A5), // Change this color to your preferred one
                                       ),
                                        child: const Text("Save"),
                                      ),
                                      const SizedBox(height: 25),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(); // Return an empty container if maxWidth is not met.
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Function to update the user's profile information in Fire store
Future<void> updateProfile(String userId, String subcollectionDocId, Map<String, dynamic> dataToUpdate,)
async {
  try {
    if (subcollectionDocId.isNotEmpty) {
      // Proceed with updating the document only if subcollectionDocId is not empty.
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's main profile document
      DocumentReference userDocRef = firestore.collection('users').doc(userId);

      // Reference to the sub collection document within the user's profile
      DocumentReference subcollectionDocRef =
      userDocRef.collection('pets_profile').doc(subcollectionDocId);

      // Update the sub collection document with the provided data
      await subcollectionDocRef.update(dataToUpdate);

      if (kDebugMode) {
        print('Sub collection document updated successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Sub collection document ID is empty. No update performed.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error updating sub collection document: $e');
    }
  }
}


