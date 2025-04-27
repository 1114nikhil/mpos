import 'package:flutter/material.dart';
import 'package:mpos/features/auth/domain/usecases/login_usecase.dart';

class AuthBloc with ChangeNotifier {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   void login(BuildContext context) async {
    try {
      bool success = await loginUseCase.execute(
        usernameController.text,
        passwordController.text,
      );

      if (success) {
        // Handle success (Navigate, show success message)
          Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Handle failure (Show error message)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
    }
  }

  void loginWithGoogle(BuildContext context) async {
    try {
      bool success = await loginUseCase.executeWithGoogle();
      if (success) {
        // Handle Google sign-in success
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google Sign-In failed")));
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
    }
  }
}