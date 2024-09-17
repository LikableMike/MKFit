import "package:cloud_firestore/cloud_firestore.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:sqflite/sqflite.dart";
import "package:firebase_storage/firebase_storage.dart";
import "dart:io";

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
    final valueNum = double.tryParse(value.toString());
    final String uid = await getUID();
    await progressCollection.doc().set(
        {"date": FieldValue.serverTimestamp(), input: valueNum, "uid": uid});
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
      TaskSnapshot taskSnapshot = await uploadTask;
      String imgUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("progress").doc().set(
          {"date": FieldValue.serverTimestamp(), "img": imgUrl, "uid": uid});
    } on FirebaseException {
      return;
    }
  }

  Future getProgress(String dtype) async {
    final String uid = await getUID();
    QuerySnapshot querySnapshot = await progressCollection
        .where("uid", isEqualTo: uid)
        .orderBy("date", descending: false)
        .get();

    List<Map<String, dynamic>> weightData = querySnapshot.docs
        .where((doc) => (doc.data() as Map<String, dynamic>).containsKey(dtype))
        .map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        "date": (data["date"] as Timestamp).toDate(),
        dtype: data[dtype].toDouble(),
      };
    }).toList();

    return weightData;
  }
}
