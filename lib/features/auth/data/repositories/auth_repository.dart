import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mpos/core/datasources/db_helper.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class AuthRepository {
  final DBHelper dbHelper = DBHelper();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  AuthRepository() {
    // Use web client ID for macOS and web, default for mobile
    print(defaultTargetPlatform);
   
    if ( defaultTargetPlatform == TargetPlatform.macOS) {
      _googleSignIn = GoogleSignIn(
        clientId: '', // Replace with your web client ID
      );
    } else {
      _googleSignIn = GoogleSignIn(); // Default for Android/iOS
    }
  }

  // Login with username and password (SQLite)
  Future<bool> loginWithCredentials(String username, String password) async {
    try {
      var user = await dbHelper.getUser(username, password);
      if (user != null) return true;
      throw Exception('Invalid username or password');
    } catch (e) {
      print("SQLite Login Error: $e");
      throw Exception('Database error: $e');
    }
  }

  // Login with Google
  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      throw Exception('Error with Google Sign-In: $e');
    }
  }

  // Sign out from Firebase and Google
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut(); // Ensures complete logout
  }
}