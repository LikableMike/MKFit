//database code 10/26
import "package:cloud_firestore/cloud_firestore.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:sqflite/sqflite.dart";
import 'dart:convert';
import "package:firebase_storage/firebase_storage.dart";
import "dart:io";
import 'package:http/http.dart' as http;
import "/backend/firebase_storage/globals.dart" as globals;

class DatabaseService {
  DatabaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference exerciseCollection =
      FirebaseFirestore.instance.collection("exercises");
  final CollectionReference exerciseTestCollection =
      FirebaseFirestore.instance.collection("exercises_test");
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final progressCollection = FirebaseFirestore.instance.collection("progress");

  Future createExercise(String name, int numSets, int numReps,
      String description, String link) async {
    await exerciseCollection.doc(name).set({
      "name": name,
      "numSets": numSets,
      "numReps": numReps,
      "description": description,
      "videoLink": link
    });
    var uid = name.toLowerCase().replaceAll(" ", "_");
    await exerciseTestCollection.doc(uid).set({
      "exercise_name": name,
      "exercise_description": description,
      "video_sample": link
    });
    return;
  }

  Future<List<Map<String, dynamic>>> getExerciseReferences(
      List<String> selectedWorkouts) async {
    List<Map<String, dynamic>> exerciseData = [];

    for (String workoutName in selectedWorkouts) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('exercises')
          .where('name', isEqualTo: workoutName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        exerciseData.add({
          'reference': querySnapshot.docs.first.reference,
          'name': workoutName,
        });
      } else {
        print('No exercise found for $workoutName');
      }
    }
    return exerciseData;
  }

  Future<void> saveWorkout(Map<String, dynamic> workoutData) async {
    try {
      String workoutName = workoutData['name'];
      List<String> selectedWorkouts = workoutData['exercises'];

      List<Map<String, dynamic>> exerciseData =
          await getExerciseReferences(selectedWorkouts);

      List<Map<String, dynamic>> exercisesToSave = exerciseData.map((data) {
        return {
          'name': data['name'],
          'reference': data['reference'],
        };
      }).toList();

      await FirebaseFirestore.instance
          .collection('workouts')
          .doc(workoutName)
          .set({
        'description': workoutData['description'],
        'exercises': exercisesToSave,
      });

      print('Workout saved successfully with exercise names and references!');
    } catch (e) {
      print('Error saving workout: $e');
    }
  }

  Future<String> getUID() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Cannot get UID: no user logged in");
    }
    return user.uid;
  }

  Future<void> createUser(String name, String username) async {
    try {
      final String uid = await getUID();
      await usersCollection.doc(uid).set({
        "name": name,
        "username": username,
        "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
      });
    } catch (e) {
      print("Error creating user: $e");
    }
  }

  Future<void> uploadProgress(String input, String value) async {
    try {
      final String uid = await getUID();
      await progressCollection.doc().set({
        "date": DateTime.now().millisecondsSinceEpoch.toString(),
        input: value,
        "uid": uid
      });
    } catch (e) {
      print("Error uploading progress: $e");
    }
  }

  Future<UploadTask?> uploadFile(
      FilePickerResult? file, String destination) async {
    if (file == null) {
      print("Cannot upload file: file is null");
      return null;
    }
    String? filePath = file.files.single.path;
    if (filePath == null) {
      print("Cannot upload file: local file path is null");
      return null;
    }

    File f = File(filePath);
    final fileRef = FirebaseStorage.instance.ref().child(destination);

    try {
      UploadTask uploadTask = fileRef.putFile(f);
      return uploadTask;
    } on FirebaseException catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }

  Future<Map<String, Map<String, List>>> getGraphData(
      List<String> attrs) async {
    final String uid = await getUID();

    Map<String, Map<String, List>> graphData = {
      for (var attr in attrs) attr: {"x": [], "y": []}
    };

    await progressCollection
        .where("uid", isEqualTo: uid)
        .orderBy("date", descending: false)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var doc = docSnapshot.data();
          for (var attr in attrs) {
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch(int.parse(doc["date"]));
            double? val = double.tryParse(doc[attr].toString());
            if (val != null) {
              graphData[attr]!["x"]!.add(date);
              graphData[attr]!["y"]!.add(val);
            }
          }
        }
      },
      onError: (e) => print("Error getting graph data: $e"),
    );
    return graphData;
  }

  Future makeAppointment(String date, String time) async {
    return await usersCollection.doc(globals.UID).update({
      "appointments": FieldValue.arrayUnion([
        {"date": date, "time": time}
      ])
    });
  }

  Future<bool> checkAppointment(String date) async {
    DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
    var appointments = snapshot.get("appointments");
    for (int i = 0; i < appointments.length; i++) {
      if (appointments[i]["date"] != null &&
          appointments[i]["date"].contains(date)) {
        return true;
      }
    }

    return false;
  }

  Future<bool> checkAdminAppointments(String date) async {
    QuerySnapshot snapshot = await usersCollection.get();
    var queryDocs = snapshot.docs;
    for (int i = 0; i < queryDocs.length; i++) {
      var userAppointments = queryDocs.elementAt(i).get("appointments");
      if (userAppointments != null) {
        for (int j = 0; j < userAppointments.length; j++) {
          if (userAppointments[j]["date"] != null &&
              userAppointments[j]["date"].contains(date)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  Future<String> checkAdminDay(String date) async {
    QuerySnapshot snapshot = await usersCollection.get();
    var queryDocs = snapshot.docs;
    var dayAppointments = "\n";
    for (int i = 0; i < queryDocs.length; i++) {
      var userAppointments = queryDocs.elementAt(i).get("appointments");
      if (userAppointments != null) {
        for (int j = 0; j < userAppointments.length; j++) {
          if (userAppointments[j]["date"] != null &&
              userAppointments[j]["date"].contains(date)) {
            print(queryDocs.elementAt(i).get("name") +
                " at " +
                userAppointments[j]["time"]);
            dayAppointments += (queryDocs.elementAt(i).get("name") +
                " at:\n " +
                userAppointments[j]["time"] +
                "\n\n");
          }
        }
      }
    }
    if (dayAppointments.trim().isEmpty) {
      dayAppointments = "No Appointments on:\n" + date;
    }
    return dayAppointments;
  }

  Future cancelAppointment(List<String> dates) async {
    DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
    var appointments = snapshot.get("appointments");

    for (String date in dates) {
      for (int i = 0; i < appointments.length; i++) {
        if (appointments[i]["date"] != null &&
            appointments[i]["date"].contains(date)) {
          print("Date Found: $date");
          await usersCollection.doc(globals.UID).update({
            "appointments": FieldValue.arrayRemove([
              {"date": appointments[i]["date"], "time": appointments[i]["time"]}
            ])
          });
        }
      }
    }
  }

  /*Future cancelAppointment(String date) async {
    DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
    var appointments = snapshot.get("appointments");
    for (int i = 0; i < appointments.length; i++) {
      if (appointments[i]["date"] != null &&
          appointments[i]["date"].contains(date)) {
        print("Date Found");
        return await usersCollection.doc(globals.UID).update({
          "appointments": FieldValue.arrayRemove([
            {"date": appointments[i]["date"], "time": appointments[i]["time"]}
          ])
        });
      }
    }
  }
*/
  Future<void> updateExercise(String attr, String doc, String val) async {
    await exerciseTestCollection.doc(doc).update({attr: val});
  }

  Future<String?> getExerciseVideo(String exercise) async {
    DocumentSnapshot snapshot =
        await exerciseTestCollection.doc(exercise).get();
    if (snapshot.exists) {
      return snapshot.get("video_sample");
    } else {
      print("Document does not exist");
      return null;
    }
  }

  Future<String?> getUserName() async {
    try {
      final String uid = await getUID();
      DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
      if (snapshot.exists) {
        return snapshot.get("name");
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user name: $e");
      return null;
    }
  }

  Future<String?> getUserHeight() async {
    try {
      final String uid = await getUID();
      DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
      if (snapshot.exists) {
        return snapshot.get("height");
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user height: $e");
      return null;
    }
  }

  Future<String?> getUserWeight() async {
    try {
      final String uid = await getUID();
      DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
      if (snapshot.exists) {
        return snapshot.get("weight");
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user weight: $e");
      return null;
    }
  }

  Future<void> sendEmail(Map<String, String> from, List<Map<String, String>> to,
      String subject, String message) async {
    var apiUrl = Uri.https('api.sendgrid.com', 'v3/mail/send');
    final headers = {
      "Authorization": "Bearer <<YOUR_API_KEY>>",
      "Content-Type": "application/json"
    };
    final data = {
      "personalizations": [
        {"to": to, "subject": subject}
      ],
      "content": [
        {"type": "text/plain", "value": message}
      ],
      "from": from,
    };

    try {
      final response =
          await http.post(apiUrl, body: jsonEncode(data), headers: headers);
      if (response.statusCode != 202) {
        print(
            'Failed to send email. Received status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending email: $e');
      return;
    }
    return;
  }

  Future<bool> getWorkouts() async {
    globals.userWorkouts.clear();
    globals.testWorkouts.clear();
    DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
    var userWorkouts = snapshot.get("workouts");
    final allWorkouts = FirebaseFirestore.instance.collection("workouts");
    final allExercises =
        FirebaseFirestore.instance.collection("exercises_test");
    for (int i = 0; i < userWorkouts.length; i++) {
      if (userWorkouts[i]["uid"] != null) {
        DocumentSnapshot WorkoutSnap =
            await allWorkouts.doc(userWorkouts[i]["uid"]).get();
        var workoutName = WorkoutSnap.get("name");
        List workoutExercises = userWorkouts[i]["exercises"];
        print(workoutExercises.toString());
        globals.testWorkouts[workoutName] = [];
        for (int j = 0; j < workoutExercises.length; j++) {
          DocumentSnapshot exerciseSnap =
              await allExercises.doc(workoutExercises[j]["uid"]).get();
          globals.testWorkouts[workoutName].add({
            "uid": workoutExercises[j]["uid"],
            "reps": workoutExercises[j]["reps"],
            "sets": workoutExercises[j]["sets"],
            "weight": workoutExercises[j]["weight"],
            "name": exerciseSnap["exercise_name"],
            "description": exerciseSnap["exercise_description"]
          });
        }
        globals.userWorkouts.add(workoutName);
        print(globals.userWorkouts.toString());
        print(globals.testWorkouts.toString());
      }
    }

    return false;
  }
}
