import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mpos/core/datasources/firebase_options.dart';
import 'package:mpos/core/routes/app_router.dart';
import 'package:mpos/features/auth/data/repositories/auth_repository.dart';
import 'package:mpos/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:mpos/features/auth/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit(); // Initialize FFI bindings
    databaseFactory = databaseFactoryFfi; // Set factory for desktop
  }

     
if(Platform.isMacOS||Platform.isWindows||kIsWeb||Platform.isIOS){
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform, );}
  else{
     await Firebase.initializeApp();
  }

  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository()),
        Provider(create: (context) => LoginUseCase(context.read<AuthRepository>())),
        ChangeNotifierProvider(create: (context) => AuthBloc(context.read<LoginUseCase>())),
      ],
      child: MaterialApp(
        title: 'Flutter Login',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,//for routing screen
        initialRoute: '/',
      ),
    );
  }
}