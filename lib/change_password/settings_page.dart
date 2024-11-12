// lib/settings_page.dart
import 'package:flutter/material.dart';
import 'change_password_page.dart';  // Import the ChangePasswordPage

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
          ),
          // Add other settings options here as needed
        ],
      ),
    );
  }
}
