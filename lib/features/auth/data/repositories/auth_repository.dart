import 'package:firebase_auth/firebase_auth.dart';
import 'package:mpos/features/auth/data/datasources/db_helper.dart';

class AuthRepository {
  final DBHelper dbHelper = DBHelper();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Login with username and password (SQLite)
  Future<bool> loginWithCredentials(String username, String password) async {
    var user = await dbHelper.getUser(username, password);
    if (user != null) {
      return true;
    }
    return false;
  }

  // Login with Google (Firebase Authentication)
  Future<User?> loginWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: (await _firebaseAuth.currentUser!.getIdToken())!,
        ),
      );

      return userCredential.user;
    } catch (e) {
      throw Exception('Error with Google Sign-In: $e');
    }
  }

  // Sign out from Firebase
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}