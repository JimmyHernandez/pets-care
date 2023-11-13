import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart'; // Import the Uuid package if you haven't already.

class PetInformationStorage {
  final TextEditingController _petNameController;
  final TextEditingController _ageController;
  final TextEditingController _breedController;
  final TextEditingController _weightController;
  final TextEditingController _foodController;
  final TextEditingController _treatsController;
  final TextEditingController _ownerController;
  final TextEditingController _phoneController;



  PetInformationStorage(
      this._petNameController,
      this._ageController,
      this._breedController,
      this._weightController,
      this._foodController,
      this._treatsController,
      this._ownerController,
      this._phoneController,
      );

  Future<void> storePetInformation() async {
    // Get the current user's UID
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;

    if (uid != null) {
      // Now, you have the user's UID and can use it to store data in "pets_profile" collection.
    }

    // Create a new instance of the UUID class
    const uuid = Uuid();

    // Generate a unique ID for the new pet
    String petId = uuid.v4();

    final petName = _petNameController.text;
    final age = _ageController.text;
    final breed = _breedController.text;
    final weight = _weightController.text;
    final food = _foodController.text;
    final treats = _treatsController.text;
    final petOwner = _ownerController.text;
    final ownerPhone = _phoneController.text;


    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    Map<String, dynamic> petData = {
      'pet_name': petName,
      'age': age,
      'breed': breed,
      'weight': weight,
      'food': food,
      'treats': treats,
      'pet_owner': petOwner,
      'owner_phone': ownerPhone,
      'pet_id': petId,

    };

    // Reference to the user's document
    DocumentReference userDocRef = fireStore.collection('users').doc(uid);
    try {
      await userDocRef.collection('pets_profile').doc(petId).set(petData);
      if (kDebugMode) {
        print('Pet information added to Fire-store successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding pet information: $e');
      }
    }
  }
}
