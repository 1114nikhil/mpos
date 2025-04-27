import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return window;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: "",
  // authDomain: "",
  // projectId: "",
  // storageBucket: "",
  // messagingSenderId: "",
  // appId: "",
  // measurementId: ""
  // );
  static const FirebaseOptions web = FirebaseOptions(
   apiKey: "AIzaSyBbKgSMl8b8A0tH3e1Q8FskfAgRuLIbyj0",
  authDomain: "mpos-2cf39.firebaseapp.com",
  projectId: "mpos-2cf39",
  storageBucket: "mpos-2cf39.firebasestorage.app",
  
  messagingSenderId: "780979485335",
  appId: "1:780979485335:web:e214243fec45631b4107d2",
  measurementId: "G-VGNG8KCNDV"
  );
  static const FirebaseOptions window = FirebaseOptions(
  apiKey: "",
  authDomain: "",
  projectId: "",
  storageBucket: "",
  messagingSenderId: "",
  appId: "",
  measurementId: ""
  );
  static const FirebaseOptions macos = FirebaseOptions(
   apiKey: "AIzaSyBbKgSMl8b8A0tH3e1Q8FskfAgRuLIbyj0",
  authDomain: "mpos-2cf39.firebaseapp.com",
  projectId: "mpos-2cf39",
  storageBucket: "mpos-2cf39.firebasestorage.app",
  messagingSenderId: "780979485335",
  appId: "1:780979485335:web:e214243fec45631b4107d2",
  measurementId: "G-VGNG8KCNDV"
  );
  
  // static const FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyAUfz3haG2b5QGqXcs203r8dOFxbNO-Uls',
  //   appId: '1:780979485335:ios:cef7ab44ab100eee4107d2',
  //   messagingSenderId: '780979485335',
  //   projectId: 'mpos-2cf39',
  //   storageBucket: 'mpos-2cf39.firebasestorage.app',
  //   iosClientId: '780979485335-3djh3seah46c311k7cjsvlc73ot9opr5.apps.googleusercontent.com',
  //   iosBundleId: 'com.example.mpos',
  // );
  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyAUfz3haG2b5QGqXcs203r8dOFxbNO-Uls',
  //   appId: '1:780979485335:ios:cef7ab44ab100eee4107d2',
  //   messagingSenderId: '780979485335',
  //   projectId: 'mpos-2cf39',
  //   storageBucket: 'mpos-2cf39.firebasestorage.app',
  //   iosClientId: '780979485335-3djh3seah46c311k7cjsvlc73ot9opr5.apps.googleusercontent.com',
  //   iosBundleId: 'com.example.mpos',
  // );
}