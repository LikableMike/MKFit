import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:sqflite/sqflite.dart";

class DatabaseService {
  DatabaseService();
  final CollectionReference exerciseCollection =
      FirebaseFirestore.instance.collection("exercises");
  final usersCollection = FirebaseFirestore.instance.collection("users");

  Future createExercise(String name, int numSets, int numReps,
      String description, String link) async {
    return await exerciseCollection.doc(name).set({
      "name": name,
      "numSets": numSets,
      "numReps": numReps,
      "description": description,
      "videoLink": link
    });
  }

  Future createUser(String name, String username) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Cannot create user document: currentUser is null.");
    }

    final uid = user.uid;
    await usersCollection.doc(uid).set({
      "name": name,
      "username": username,
      "createdAt": FieldValue.serverTimestamp()
    });
  }
}
