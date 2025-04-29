import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mpos/core/datasources/firebase_options.dart';
import 'package:mpos/core/routes/app_router.dart';
import 'package:mpos/core/utils/app_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit(); // Initialize FFI bindings
    databaseFactory = databaseFactoryFfi; // Set factory for desktop
  }

     
await Firebase.initializeApp(
  options: kIsWeb || Platform.isWindows || Platform.isMacOS
      ? DefaultFirebaseOptions.currentPlatform
      : null, // <- For Android/iOS, use native plist/json config
);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Flutter Login',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}