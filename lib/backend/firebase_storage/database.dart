import "package:cloud_firestore/cloud_firestore.dart";
import "package:sqflite/sqflite.dart";

class DatabaseService{

  DatabaseService();
  final CollectionReference exerciseCollection = FirebaseFirestore.instance.collection("exercises");

  Future createExercise(String name, int numSets, int numReps, String description, String link) async{
    return await exerciseCollection.doc(name).set({
      "name" : name,
      "numSets" : numSets,
      "numReps" : numReps,
      "description" : description,
      "videoLink" : link
    });
  }
}