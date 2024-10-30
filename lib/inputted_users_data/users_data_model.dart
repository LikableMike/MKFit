import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  // Replace with the actual user ID
  final String userId = 'exampleUserId';

  // Function to store user data in Firestore
  Future<void> storeUserData(Map<String, dynamic> inputData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('workouts')
          .add({
        ...inputData,
        'timestamp': FieldValue.serverTimestamp(), // Automatically set the timestamp
      });
      print("Document successfully written!"); // Success message
    } catch (e) {
      // Handle any errors during the data addition
      print("Error adding document: $e");
    }
  }
}
