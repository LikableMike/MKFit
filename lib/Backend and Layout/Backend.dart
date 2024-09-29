import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Backend {
  String id;
  String title;
  String description;
  int duration; // in minutes
  String category;

  Workout({required this.id, required this.title, required this.description, required this.duration, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
      'category': category,
    };
  }

  factory Workout.fromMap(String id, Map<String, dynamic> map) {
    return Workout(
      id: id,
      title: map['title'],
      description: map['description'],
      duration: map['duration'],
      category: map['category'],
    );
  }
}

class WorkoutService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addWorkout(Workout workout) async {
    await _db.collection('workouts').add(workout.toMap());
  }

  Future<List<Workout>> fetchWorkouts() async {
    final snapshot = await _db.collection('workouts').get();
    return snapshot.docs.map((doc) => Workout.fromMap(doc.id, doc.data())).toList();
  }
}
