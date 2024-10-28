import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  // Placeholder for the user ID
  final String userId = 'exampleUserId';

  // Method to retrieve user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?; // Return user information
      }
    } catch (e) {
      print("An error occurred while fetching user data: $e");
    }
    return null; // Return null if no data is available
  }
}