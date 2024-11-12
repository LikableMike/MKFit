// lib/firebase_auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reauthenticate user to allow password change
  Future<User?> reauthenticateUser(String currentPassword) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(message: 'No user is logged in.');
    }

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);
    return user;
  }

  // Change user password
  Future<void> changePassword(String newPassword) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(message: 'No user is logged in.');
    }
    await user.updatePassword(newPassword);
    await user.reload();
  }

  // Log out the user
  Future<void> logOut() async {
    await _auth.signOut();
  }
}