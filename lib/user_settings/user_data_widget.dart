import 'package:flutter/material.dart';
import 'user_data_model.dart'; // Import the user data model

class UserDataWidget extends StatefulWidget {
  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  final UserDataModel userDataModel = UserDataModel(); // Instantiate the model
  Map<String, dynamic>? userData; // Variable to store fetched user data

  @override
  void initState() {
    super.initState();
    _retrieveUserData(); // Fetch user data when the widget initializes
  }

  // Method to fetch user data
  void _retrieveUserData() async {
    userData = await userDataModel.fetchUserData();
    setState(() {}); // Update the UI after data is retrieved
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Settings')), // Title for the app bar
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: userData == null // Check if user data has been loaded
            ? Center(child: CircularProgressIndicator()) // Display loading spinner while data is fetched
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${userData!['username'] ?? 'N/A'}'),
                  Text('Height: ${userData!['height'] ?? 'N/A'} cm'),
                  Text('Weight: ${userData!['weight'] ?? 'N/A'} kg'),
                  Text('Address: ${userData!['address'] ?? 'N/A'}'),
                  // Include additional fields as needed
                ],
              ),
      ),
    );
  }
}