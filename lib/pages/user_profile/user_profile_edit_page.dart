import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/user_profile/user_profile_page.dart';

import '../../functions - jimmy/userpicture_input.dart';

User? userid = FirebaseAuth.instance.currentUser;

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({super.key});

  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  // Define controllers for the text fields
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    nameController.dispose();
    super.dispose();
  }

  // Function to update the user's profile information in Firestore
  Future<void> updateProfile(String userId, Map<String, dynamic> dataToUpdate) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection('users').doc(userId);
      await userDocRef.update(dataToUpdate);
      if (kDebugMode) {
        print('Profile updated successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating profile: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit User Profile",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to the one you prefer
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Change this color to the one you prefer
      ),

      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(250, 25, 250, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const ImagePickerWidget(),
            const SizedBox(height: 30),

        SizedBox(
          width: 400,
              child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Color(0xff0849ea),
                ),
              ),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            // You can also include buttons to edit or follow the user, or any other actions
           ),const SizedBox(height: 10),
            // Include your widgets here, such as ImagePickerWidget, TextFormField, and others

            ElevatedButton(
               onPressed: () async {
                // Save the edited profile data
                String editedName = nameController.text;

                // Create a map with the data to update in Firestore
                Map<String, dynamic> profileUpdates = {
                  'name': editedName,
                  // Add other fields to update here
                };

                // Call the updateProfile function to update Firestore
                await updateProfile(userid!.uid, profileUpdates);

                // After updating the profile, navigate back to the user profile page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: const Text("Save"),
              ),
            const SizedBox(height: 25),

            AlertDialog(
              title: Text('Delete Account from ${userid?.email}'),
              content: Text('Are you sure you want to delete your account? This action cannot be undone, and all your data will be lost.'),
              actions: [
                 TextButton(
                  onPressed: () {
                    _deleteAccount(); // Call the delete account function
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
               const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

Future<void> _deleteAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
      if (kDebugMode) {
        print('Account deleted successfully.');
      }

    } else {
      if (kDebugMode) {
        print('No user signed in.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error deleting account: $e');
    }
  }
}

