// firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_availability_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveAvailability(Map<String, AdminAvailability> availability) async {
    await _db.collection('admin_availability').doc('admin_id').set({
      'availability': availability.map((key, value) => MapEntry(key, value.toJson())),
    });
  }

  Future<Map<String, AdminAvailability>> getAvailability() async {
    DocumentSnapshot snapshot = await _db.collection('admin_availability').doc('admin_id').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data['availability']
          .map<String, AdminAvailability>((key, value) =>
              MapEntry(key, AdminAvailability.fromJson(value)));
    }
    return {};
  }
}