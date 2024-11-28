// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'settings_page.dart';  // Import the SettingsPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MKFitApp());
}

class MKFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKFit',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SettingsPage(),  // Set the home page to the Settings page
    );
  }
}
