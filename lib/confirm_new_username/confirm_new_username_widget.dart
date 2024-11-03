/*
Ramin Selseleh

Substask: MA-150

The point of this task was to fix the icon image and the fuinctionality of the back button.
Now, the button is visible and functional. Now when clicked, it will navigate back to previous page.

Stephanie Nutter:
MA - 229:
Change username function now works and is completely validated.

 */
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

export 'confirm_new_username_model.dart';

class ConfirmNewUsernameWidget extends StatefulWidget {
  const ConfirmNewUsernameWidget({super.key});

  @override
  State<ConfirmNewUsernameWidget> createState() =>
      _ConfirmNewUsernameWidgetState();
}

class _ConfirmNewUsernameWidgetState extends State<ConfirmNewUsernameWidget> {
  late TextEditingController newUsernameController;
  late TextEditingController confirmUsernameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    newUsernameController = TextEditingController();
    confirmUsernameController = TextEditingController();
  }

  @override
  void dispose() {
    newUsernameController.dispose();
    confirmUsernameController.dispose();
    super.dispose();
  }

  //Username validation
  String? validateUsername(String? value) {
    //Username cannot be null
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty.';
    }
    //Username must be greater than 8 characters
    if (value.length < 8) {
      return 'Username must be at least 8 characters.';
    }
    final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    //Username must be alphanumeric
    if (!alphanumeric.hasMatch(value)) {
      return 'Only alphanumeric values are allowed.';
    }
    return null;
  }

  Future<void> updateUsername() async {
    final newUsername = newUsernameController.text.trim();
    final confirmedUsername = confirmUsernameController.text.trim();

    // Basic validation for empty fields
    if (newUsername.isEmpty || confirmedUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in both fields.")),
      );
      return;
    }

    // Validate the new username
    String? validationMessage = validateUsername(newUsername);
    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationMessage)),
      );
      return;
    }

    // Check if the usernames match
    if (newUsername != confirmedUsername) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usernames do not match.")),
      );
      return;
    }

    //TESTING PURPOSES: Check is user exists
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not authenticated.")),
      );
      return;
    }

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
      await docRef.update({'username': newUsername});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username updated successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating username: $e")),
      );
      print("Error updating username: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            Text(
              'Change Username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            //Description
            Text(
              'Please confirm your new Username by filling out the fields below.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            //Alphanumeric warning
            Text(
              'Alphanumeric (A, a, B, b, 1, 2, 3, etc) values only.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            // New Username Field
            TextFormField(
                controller: newUsernameController,
                decoration: InputDecoration(
                  labelText: 'New Username',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter New Username',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.black,
                  contentPadding: EdgeInsets.all(16),
                ),
                style: TextStyle(color: Colors.white),
                validator: validateUsername
            ),
            SizedBox(height: 16),
        // Confirm Username Field
            TextFormField(
              controller: confirmUsernameController,
              decoration: InputDecoration(
                labelText: 'Confirm Username',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Confirm New Username',
                hintStyle: TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.black,
                contentPadding: EdgeInsets.all(16),
              ),
              style: TextStyle(color: Colors.white),
              validator: validateUsername,
            ),
            SizedBox(height: 20),
            // Submit Button
        ElevatedButton(
          onPressed: updateUsername,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Container(
            width: double.infinity,
            child: Text(
              'Submit',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
              ),
            )
        ),
       ],
     ),
    )
    );
  }
}
