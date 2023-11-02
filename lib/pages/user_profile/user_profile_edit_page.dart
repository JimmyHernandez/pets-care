import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pets_care/pages/welcome/introduction_page.dart';

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
        title: const Text("Edit Profile",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Chan
        // Change this color to the one you prefer
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the back button color to blue
        ),
        actions: const [SizedBox(width: 1),
        ],
      ),

      body: Padding(

        padding: const EdgeInsetsDirectional.fromSTEB(250, 25, 250, 25),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            const ImagePickerWidget(),
            const SizedBox(height: 30),
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
                      return Text('${snapshot.data}', style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24, // Font size
                        fontWeight: FontWeight.bold,
                        // Change the title color to black
                      ),
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text('User is not logged in or name is not available.');
                    }
                  },
                ),
              ],
            ),const SizedBox(height: 25),

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
           ),const SizedBox(height: 25),
            // Include your widgets here, such as ImagePickerWidget, TextFormField, and others

          ElevatedButton(
            onPressed: () async {
              // Save the edited profile data
              String editedName = nameController.text;

              // Check if the editedName is not empty
              if (editedName.isNotEmpty) {
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
                  MaterialPageRoute(builder: (context) => const UserProfileEdit()),
                );
              } else {
                // Handle the case where the editedName is empty, e.g., show an error message.
                // You can display a snackbar using ScaffoldMessenger.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Name cannot be empty'),
                  ),
                );
              }
            },
            child: const Text("Save"),
          )
          ,const SizedBox(height: 25),

              AlertDialog(
              title: Text('Delete Account from email: ${userid?.email}'),
              content: const Text('Are you sure you want to delete your account? This action cannot be undone, and all your data will be lost.'),
              actions: [
                TextButton(
              onPressed: () async {
                    bool deleteConfirmed = await showDialog(
                    context: context,
                    builder: (
                    BuildContext context) {
                    return AlertDialog(
                        title: const Text(
                        'Confirm Deletion'),
                        content:
                        const Text(
                        'Are you sure you want to delete this profile?'),
                        actions: [

                              TextButton(
                              onPressed: () =>
                              Navigator.of(
                              context).pop(
                              false),
                              child: const Text(
                              'Cancel'),
                              ),

                              TextButton(
                              onPressed: () {
                                _deleteAccount();
                                Navigator.of(context).pop(true);
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (
                                    context) => const WelcomeScreen()),
                                             );
                                    },
                              child: const Text(
                              'Delete'),
                              ),
                        ],
                    );
                    },
                    );
                    if (deleteConfirmed) {
                    // Profile deleted, you can update the UI or show a message
                    }
                    },
                  child: const Text('Delete'),
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

