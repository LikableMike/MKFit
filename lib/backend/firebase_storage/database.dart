import "package:cloud_firestore/cloud_firestore.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:sqflite/sqflite.dart";
import "package:firebase_storage/firebase_storage.dart";
import "dart:io";
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
  final List<String> adminUIDs = [
    "Qtg99NjZtpZW7EvWOYoy7Xvh7kF3",
    "nOlIEy4WKkddkikrMPhQNLEjT9y1",
    // Add more UIDs as needed
  ];
  Future<bool> isAppointmentAvailable(DateTime newAppointmentStart, DateTime newAppointmentEnd) async {
    try {
      String userId = await getUID();
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      if (userSnapshot.exists) {
        List<dynamic> appointments = userSnapshot['appointments'] ?? [];

        for (var appointment in appointments) {
          // Check if the 'startTime' and 'endTime' exist and are not null
          if (appointment['startTime'] != null && appointment['endTime'] != null) {
            DateTime existingAppointmentStart = (appointment['startTime'] as Timestamp).toDate();
            DateTime existingAppointmentEnd = (appointment['endTime'] as Timestamp).toDate();

            // Check for overlap
            if (newAppointmentStart.isBefore(existingAppointmentEnd) && newAppointmentEnd.isAfter(existingAppointmentStart)) {
              return false;  // Overlap found, appointment not available
            }
          }
        }
      }

      return true;  // No overlap found, appointment available
    } catch (e) {
      print("Error checking appointment availability: $e");
      return false;
    }
  }
  Future<String> addAppointment(DateTime newAppointmentStart, DateTime newAppointmentEnd) async {
    // Check if the time range is available
    bool isAvailable = await isAppointmentAvailable(newAppointmentStart, newAppointmentEnd);

    if (isAvailable) {
      try {
        String userId = await getUID();

        // Update the user's document with the new appointment range
        await usersCollection.doc(userId).update({
          'appointments': FieldValue.arrayUnion([
            {
              'startTime': Timestamp.fromDate(newAppointmentStart),
              'endTime': Timestamp.fromDate(newAppointmentEnd)
            }
          ]),
        });

        return 'Appointment successfully added!';
      } catch (e) {
        print("Error adding appointment: $e");
        return 'Error adding appointment. Please try again.';
      }
    } else {
      return 'This time slot is already taken. Please choose another.';
    }
  }
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

  Future<List<Map<String, dynamic>>> getExerciseReferences(List<String> selectedWorkouts) async{
    List<Map<String, dynamic>> exerciseData = [];

    for(String workoutName in selectedWorkouts){
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('exercises')
            .where('name', isEqualTo: workoutName)
            .limit(1)
            .get();

        if(querySnapshot.docs.isNotEmpty){
            exerciseData.add({
                'reference': querySnapshot.docs.first.reference,
                'name':workoutName,
            });
        } else{
            print('No exercise found for $workoutName');
        }
    }
    return exerciseData;
  }

  Future<void> saveWorkout(Map<String, dynamic> workoutData) async {
    try {
      String workoutName = workoutData['name'];
      List<String> selectedWorkouts = workoutData['exercises'];

      List<Map<String, dynamic>> exerciseData = await getExerciseReferences(selectedWorkouts);

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

  Future cancelAppointment(String date) async {
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
      try{
          final String uid = await getUID();
          DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
          if(snapshot.exists) {
              return snapshot.get("name");
          }
          else{
              print("User document does not exist");
              return null;
          }
      }
      catch(e) {
          print("Error fetching user name: $e");
          return null;
      }
    }
    Future<String?> getUserHeight() async {
        try{
            final String uid = await getUID();
            DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
            if(snapshot.exists) {
                return snapshot.get("height");
            }
            else{
                print("User document does not exist");
                return null;
            }
        }
        catch(e) {
            print("Error fetching user height: $e");
            return null;
        }
    }
    Future<String?> getUserWeight() async {
          try{
              final String uid = await getUID();
              DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
              if(snapshot.exists) {
                  return snapshot.get("weight");
              }
              else{
                  print("User document does not exist");
                  return null;
              }
          }
          catch(e) {
              print("Error fetching user weight: $e");
              return null;
          }
  }
}
