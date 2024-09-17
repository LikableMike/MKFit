import "package:cloud_firestore/cloud_firestore.dart";
import "package:file_picker/file_picker.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:sqflite/sqflite.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  DatabaseService();
  final CollectionReference exerciseCollection =
      FirebaseFirestore.instance.collection("exercises");
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final progressCollection = FirebaseFirestore.instance.collection("progress");

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

  Future getUID() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Cannot create user document: currentUser is null.");
    }
    return user.uid;
  }

  Future createUser(String name, String username) async {
    final String uid = await getUID();
    await usersCollection.doc(uid).set({
      "name": name,
      "username": username,
      "createdAt": FieldValue.serverTimestamp()
    });
  }

  Future uploadProgress(String input, String value) async {
    double? weight;
    double? bmi;
    final valueNum = double.tryParse(value.toString());
    if (valueNum != null) {
      if (input == "weight") {
        weight = valueNum;
      } else if (input == "bmi") {
        bmi = valueNum;
      } else {
        return;
      }
    }

    final String uid = await getUID();
    await progressCollection.doc().set({
      "date": FieldValue.serverTimestamp(),
      "weight": weight,
      "bmi": bmi,
      "img": null,
      "uid": uid
    });
  }

  Future uploadImage(FilePickerResult? file) async {
    if (file == null) {
      return;
    }
    String? filePath = file.files.single.path;
    if (filePath == null) {
      return;
    }

    final String uid = await getUID();
    File img = File(filePath);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg");

    try {
      UploadTask uploadTask = storageRef.putFile(img);
      TaskSnapshot snapshot = await uploadTask;
      String imgUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('progress').doc().set({
        "date": FieldValue.serverTimestamp(),
        "weight": null,
        "bmi": null,
        "img": imgUrl,
        "uid": uid
      });
    } on FirebaseException {
      return;
    }
  }
}
