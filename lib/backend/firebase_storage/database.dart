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
  final List<String> adminUIDs = [
    "Qtg99NjZtpZW7EvWOYoy7Xvh7kF3",
    "nOlIEy4WKkddkikrMPhQNLEjT9y1",
    // Add more UIDs as needed
  ];
  Future<bool> isAppointmentAvailable(DateTime newAppointmentStart) async {
    try {
      DocumentReference startTimeDoc = FirebaseFirestore.instance.collection('appointments').doc('allStartTimes');
      DocumentSnapshot snapshot = await startTimeDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic> startTimes = snapshot['startTimes'] ?? [];
        for (var startTime in startTimes) {
          DateTime existingAppointmentStart = (startTime as Timestamp).toDate();
          if (existingAppointmentStart.isAtSameMomentAs(newAppointmentStart)) {
            return false;
          }
        }
      }
      return true;
    } catch (e) {
      print("Error checking appointment availability: $e");
      return false;
    }
  }
  Future<String> addAppointment(DateTime newAppointmentStart, DateTime newAppointmentEnd) async {
    // Check if the time range is available
    bool isAvailable = await isAppointmentAvailable(newAppointmentStart);

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

        DocumentReference startTimeDoc = FirebaseFirestore.instance.collection('appointments').doc('allStartTimes');

        await startTimeDoc.set({
            'startTimes':FieldValue.arrayUnion([Timestamp.fromDate(newAppointmentStart)])
        }, SetOptions(merge: true));

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
  Future<String?> getAppointmentTime(String date) async {
    DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
    if (snapshot.exists && snapshot.data() != null) {
      var appointments = snapshot.get("appointments");
      for (int i = 0; i < appointments.length; i++) {
        if (appointments[i]["startTime"] != null) {
          DateTime startTime =
          (appointments[i]["startTime"] as Timestamp).toDate();
          String storedDate = DateFormat('yyyy-MM-dd').format(startTime);
          if (storedDate == date) {
            return DateFormat('hh:mm a').format(startTime);
          }
        }
      }
    }
    return null; // Return null if no appointment is found for the given date
  }

  Future<Map<String, dynamic>?> getNextAppointment() async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic> appointments = snapshot.get("appointments");

        if (appointments.isEmpty) {
          return null;
        }

        // Sort appointments by date
        appointments.sort((a, b) {
          DateTime aDate = (a['startTime'] as Timestamp).toDate();
          DateTime bDate = (b['startTime'] as Timestamp).toDate();
          return aDate.compareTo(bDate);
        });

        // Get the earliest appointment
        Map<String, dynamic> nextAppointment = appointments.first;
        DateTime appointmentDate =
        (nextAppointment['startTime'] as Timestamp).toDate();
        TimeOfDay appointmentTime = TimeOfDay.fromDateTime(appointmentDate);

        return {'date': appointmentDate, 'time': appointmentTime};
      }
    } catch (e) {
      print("Error fetching next appointment: $e");
    }
    return null;
  }

  Future<bool> checkAppointment(String date) async {
    DocumentSnapshot snapshot = await usersCollection.doc(globals.UID).get();
    if (snapshot.exists && snapshot.data() != null) {
      var appointments = snapshot.get("appointments");
      for (int i = 0; i < appointments.length; i++) {
        if (appointments[i]["startTime"] != null) {
          DateTime startTime =
          (appointments[i]["startTime"] as Timestamp).toDate();
          String storedDate = DateFormat('yyyy-MM-dd').format(startTime);
          if (storedDate == date) {
            return true;
          }
        }
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

  Future<void> cancelAppointment(List<String> dates) async {
    try {
      String userId = await getUID(); // Get the current user ID

      // Step 1: Remove from User's Appointments
      DocumentSnapshot snapshot = await usersCollection.doc(userId).get();
      if (snapshot.exists && snapshot.data() != null) {
        var appointments = snapshot.get("appointments");

        List<Map<String, dynamic>> appointmentsToRemove = [];

        for (String date in dates) {
          for (int i = 0; i < appointments.length; i++) {
            if (appointments[i]["startTime"] != null) {
              DateTime startTime = (appointments[i]["startTime"] as Timestamp).toDate();
              String storedDate = DateFormat('yyyy-MM-dd').format(startTime);

              if (storedDate == date) {
                // Collect the appointment to remove
                appointmentsToRemove.add(appointments[i]);
              }
            }
          }
        }

        // Remove appointments from the user's list
        if (appointmentsToRemove.isNotEmpty) {
          await usersCollection.doc(userId).update({
            "appointments": FieldValue.arrayRemove(appointmentsToRemove),
          });
        }

        // Step 2: Remove from allStartTimes Collection for the specific user only
        DocumentReference startTimeDoc = FirebaseFirestore.instance.collection('appointments').doc('allStartTimes');
        DocumentSnapshot allStartTimesSnapshot = await startTimeDoc.get();

        if (allStartTimesSnapshot.exists && allStartTimesSnapshot.data() != null) {
          List<dynamic> startTimes = allStartTimesSnapshot['startTimes'] ?? [];
          List<dynamic> updatedStartTimes = [];

          for (var startTimeEntry in startTimes) {
            if (startTimeEntry is Map<String, dynamic>) {
              DateTime existingAppointmentStart = (startTimeEntry['timestamp'] as Timestamp).toDate();
              String storedDate = DateFormat('yyyy-MM-dd').format(existingAppointmentStart);
              String existingUserId = startTimeEntry['userId'];

              // Keep only those times that are not being canceled for the current user
              if (!(dates.contains(storedDate) && existingUserId == userId)) {
                updatedStartTimes.add(startTimeEntry);
              }
            }
          }

          // Update the allStartTimes document with the updated times
          await startTimeDoc.update({"startTimes": updatedStartTimes});
        }

        print('Appointments removed successfully.');
      }
    } catch (e) {
      print("Error cancelling appointment: $e");
    }
  }



  Future<String> findClientName(String uid) async{
    DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
    var name = snapshot.get("name");
    print(name);
    return name;
  }

  Future<List> getClients() async{
    QuerySnapshot snapshot = await usersCollection.get();
    List clientsHold = [];
    for (var doc in snapshot.docs){
      clientsHold.add(doc.id);
    }
    globals.clientUIDS = clientsHold;
    print(globals.clientUIDS.length);
    return globals.clientUIDS;

  }

  Future<void> updateUserWeight(String weight) async {
    try {
      final String uid = await getUID(); // Fetch user ID
      await usersCollection.doc(uid).update({"weight": weight});
      print("Weight updated successfully.");
    } catch (e) {
      print("Error updating weight: $e");
    }
  }
  Future<void> updateUserWeightAndHeight(String weight, String height) async {
    try {
      final String uid = await getUID(); // Get the user's UID
      await usersCollection.doc(uid).update({
        "weight": weight,
        "height": height,
      });
      print("User weight and height updated successfully.");
    } catch (e) {
      print("Error updating weight and height: $e");
    }
  }

  Future cancelClientAppointment(String date) async {
    DocumentSnapshot snapshot = await usersCollection.doc(globals.selectedClient).get();

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

  //Workout Page Widget
  //Dynamically calls exercise_names 
 Future<List<String>> fetchExercises() async {
    try {
      // Fetch the main collection 'exercises'
      final snapshot = await _firestore.collection('exercises').get();
      List<String> exerciseNames = [];

      // Iterate through each document in the main collection
      for (var doc in snapshot.docs) {
      //Prints each document ID
        print('Document ID: ${doc.id}');

        // Fetch the subcollection 'exercises' under each document
        final subcollectionSnapshot = await doc.reference.collection('exercises').get();

        // Iterate through each document in the subcollection
        for (var subDoc in subcollectionSnapshot.docs) {
          print('Sub Document ID: ${subDoc.id}, Data: ${subDoc.data()}');

          // Ensure the key 'exercise_name' exists before accessing it
          if (subDoc.data().containsKey('exercise_name')) {
            exerciseNames.add(subDoc['exercise_name'].toString());
          }
        }
      }
      // Print the final list
      print('Fetched Exercises: $exerciseNames');
      return exerciseNames;
    } catch (e) {
      print('Error fetching exercises: $e');
      return [];
    }
  }

}
