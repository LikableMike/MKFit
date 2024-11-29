// lib/change_password_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _errorMessage = '';

  // Function to change the password
  Future<void> _changePassword() async {
    if (_newPasswordController.text != _confirmNewPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Get the current user
      User? user = _auth.currentUser;

      if (user == null) {
        setState(() {
          _errorMessage = 'No user is logged in.';
          _isLoading = false;
        });
        return;
      }

      // Reauthenticate the user to allow password change
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text,
      );

      await user.reauthenticateWithCredential(credential);

      // Now that the user is reauthenticated, change the password
      await user.updatePassword(_newPasswordController.text);
      await user.reload();
      user = _auth.currentUser;

      // After changing the password, log the user out and ask them to log in again
      await _auth.signOut();
      
      setState(() {
        _isLoading = false;
      });

      // Show a success message and prompt the user to log in again
      _showSuccessDialog();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  // Function to show success dialog after password change
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Password Changed Successfully'),
        content: Text('Please log in with your new password.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Pop back to the login screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                labelStyle: TextStyle(color: Colors.white), // Add this line
                errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white), // Add this line
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _confirmNewPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                labelStyle: TextStyle(color: Colors.white), // Add this line
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _changePassword,
                    child: Text('Change Password'),
                  ),
          ],
        ),
      ),
    );
  }
}