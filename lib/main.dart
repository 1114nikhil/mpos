import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpos/features/auth/data/datasources/firebase_options.dart';
import 'package:mpos/features/auth/data/repositories/auth_repository.dart';
import 'package:mpos/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:mpos/features/auth/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';// Add this import
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: LoginScreen(),
      ),
    );
  }
}