// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
// import 'package:google_sign_in/google_sign_in.dart' as mobile; // Alias for mobile
// import 'package:mpos/core/datasources/db_helper.dart'; // Alias for web
// import 'package:google_sign_in_web/google_sign_in_web.dart' as web;
    // show defaultTargetPlatform, TargetPlatform;
    

// class AuthRepository {
//   final DBHelper dbHelper = DBHelper();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   late final GoogleSignIn _googleSignIn;

//   AuthRepository() {
//     // Use web client ID for macOS and web, default for mobile
//     print(defaultTargetPlatform);
   
//     if ( defaultTargetPlatform == TargetPlatform.windows) {
//       _googleSignIn = GoogleSignIn(
//         clientId: '', // Replace with your web client ID
//       );
//     } else {
//       _googleSignIn = GoogleSignIn(); // Default for Android/iOS
//     }
//   }

//   // Login with username and password (SQLite)
//   Future<bool> loginWithCredentials(String username, String password) async {
//     try {
//       var user = await dbHelper.getUser(username, password);
//       if (user != null) return true;
//       throw Exception('Invalid username or password');
//     } catch (e) {
//       print("SQLite Login Error: $e");
//       throw Exception('Database error: $e');
//     }
//   }

//   // Login with Google
//   Future<User?> loginWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       throw Exception('Error with Google Sign-In: $e');
//     }
//   }

//   // Sign out from Firebase and Google
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//     await _googleSignIn.signOut(); // Ensures complete logout
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:google_sign_in/google_sign_in.dart' as mobile;
import 'package:http/http.dart' as http;
import 'package:mpos/core/datasources/db_helper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:url_launcher/url_launcher.dart';

class AuthRepository {
  final DBHelper dbHelper = DBHelper();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final mobile.GoogleSignIn? _googleSignIn;

  // Google OAuth client ID and redirect URI for desktop
  static const String clientId = ''; // Your web client ID
  static const String redirectUri = '';
  static const String clientSecret = ''; // Add your client secret from Firebase/Google Console

  AuthRepository() {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS) {
      _googleSignIn = null; // No mobile GoogleSignIn for web/desktop
    } else {
      _googleSignIn = mobile.GoogleSignIn(); // Mobile only
    }
  }

  // Login with username and password (SQLite)
  Future<bool> loginWithCredentials(String username, String password) async {
    try {
      var user = await dbHelper.getUser(username, password);
      print('loginWithCredentials ${username} ,${password}');
      if (user != null) return true;
      throw Exception('Invalid username or password');
    } catch (e) {
      print("SQLite Login Error: $e");
      throw Exception('Database error: $e');
    }
  }

  Future<bool> signUpWithCredentials(String username, String password) async {
    try {
      // Check if username already exists
      final existingUser = await dbHelper.getUserByUsername(username);
      if (existingUser != null) {
        throw Exception('Username already exists');
      }
      await dbHelper.insertUser(username, password);
      return true;
    } catch (e) {
      print("SQLite SignUp Error: $e");
      throw Exception('Database error: $e');
    }
  }

  // Login with Google
  Future<User?> loginWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: Use Firebase's signInWithPopup
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        UserCredential userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        return userCredential.user;
      } else if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS) {
        // Desktop: Custom OAuth flow
        return await _loginWithGoogleDesktop();
      } else {
        // Mobile: Use google_sign_in
        final mobile.GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();
        if (googleUser == null) return null;

        final mobile.GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      throw Exception('Error with Google Sign-In: $e');
    }
  }

  // Custom Google Sign-In for desktop
  Future<User?> _loginWithGoogleDesktop() async {
    // Start a local server to handle the redirect
    final server = await shelf_io.serve(
      (Request request) async {
        if (request.url.path == 'auth/google/callback') {
          final code = request.url.queryParameters['code'];
          if (code != null) {
            // Exchange code for tokens
            final tokens = await _exchangeCodeForTokens(code);
            final credential = GoogleAuthProvider.credential(
              idToken: tokens['id_token'],
              accessToken: tokens['access_token'],
            );
            final userCredential = await _firebaseAuth.signInWithCredential(credential);
            return Response.ok('Login successful, you can close this window.');
          }
          return Response.badRequest(body: 'No code provided');
        }
        return Response.notFound('Not found');
      },
      InternetAddress.loopbackIPv4,
      8080,
    );

    // Construct Google OAuth URL
    final authUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': 'code',
      'scope': 'email profile openid',
    });

    // Launch the browser
    if (!await launchUrl(authUrl)) {
      await server.close();
      throw Exception('Could not launch $authUrl');
    }

    // Wait for the server to handle the redirect (this is simplified; in practice, use a Future to wait for the response)
    await Future.delayed(Duration(seconds: 30)); // Adjust timeout as needed
    await server.close();

    // Return the current user (assumes sign-in completed successfully)
    return _firebaseAuth.currentUser;
  }

  // Exchange authorization code for tokens
  Future<Map<String, dynamic>> _exchangeCodeForTokens(String code) async {
    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      body: {
        'code': code,
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'grant_type': 'authorization_code',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to exchange code for tokens: ${response.body}');
    }
  }

  // Sign out from Firebase and Google
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (!(kIsWeb || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS)) {
      await _googleSignIn?.signOut();
    }
  }
}