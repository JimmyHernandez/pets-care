import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void deleteProfile(String profileId) async {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference<Map<String, dynamic>> collectionRef =
  FirebaseFirestore.instance.collection('users');

  DocumentSnapshot<Map<String, dynamic>> collectionSnapshot =
  await collectionRef.doc(user?.uid).get();

  CollectionReference<Map<String, dynamic>> subcollectionRef =
  collectionSnapshot.reference.collection('pets_profile');

  // Delete the profile document with the given ID
  await subcollectionRef.doc(profileId).delete();

}


