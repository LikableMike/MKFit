import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user_data_widget.dart'; // Import the user data widget

void main() async {
  // Ensure widget binding is initialized before using Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Start the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKFit Workout Tracker', // App title
      home: UserDataWidget(), // Set the home screen to UserDataWidget
    );
  }
}