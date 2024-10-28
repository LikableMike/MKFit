import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'users_data_widget.dart'; // Import the widget

void main() async {
  // Ensure that widget binding is initialized before using Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKFit Workout Tracker', // Title of the app
      home: UsersDataWidget(), // Set the home screen to UsersDataWidget
    );
  }
}
