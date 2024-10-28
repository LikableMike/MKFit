import 'package:flutter/material.dart';
import 'users_data_model.dart'; // Import the model

class UsersDataWidget extends StatefulWidget {
  @override
  _UsersDataWidgetState createState() => _UsersDataWidgetState();
}

class _UsersDataWidgetState extends State<UsersDataWidget> {
  // Controllers to manage input fields
  final _workoutTypeController = TextEditingController();
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  
  final UserDataModel userDataModel = UserDataModel(); // Create an instance of the model

  // Function to handle form submission
  void _submitData() {
    // Validate inputs before storing
    if (_workoutTypeController.text.isEmpty ||
        _durationController.text.isEmpty ||
        _caloriesController.text.isEmpty) {
      return; // Early exit if validation fails
    }

    final workoutData = {
      'type': _workoutTypeController.text,
      'duration': int.parse(_durationController.text), // Convert to integer
      'caloriesBurned': int.parse(_caloriesController.text), // Convert to integer
    };

    // Store the collected data
    userDataModel.storeUserData(workoutData);

    // Clear input fields after submission
    _workoutTypeController.clear();
    _durationController.clear();
    _caloriesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MKFit Workout Tracker')), // App bar title
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the form
        child: Column(
          children: [
            // Input field for workout type
            TextField(
              controller: _workoutTypeController,
              decoration: InputDecoration(labelText: 'Workout Type'),
            ),
            // Input field for duration in minutes
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number, // Numeric keyboard
            ),
            // Input field for calories burned
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories Burned'),
              keyboardType: TextInputType.number, // Numeric keyboard
            ),
            SizedBox(height: 20), // Space between input fields and button
            ElevatedButton(
              onPressed: _submitData, // Call submit function on press
              child: Text('Save Workout'), // Button label
            ),
          ],
        ),
      ),
    );
  }
}
