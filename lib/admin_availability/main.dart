// main.dart
import 'package:flutter/material.dart';
import 'admin_availability_page.dart';
import 'client_schedule_page.dart';

void main() {
  runApp(MKFitApp());
}

class MKFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKFit',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => AdminAvailabilityPage(),
        '/schedule': (context) => ClientSchedulePage(),
      },
    );
  }
}
