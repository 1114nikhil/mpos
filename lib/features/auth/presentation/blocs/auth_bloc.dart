import 'package:flutter/material.dart';
import 'package:mpos/features/auth/domain/usecases/login_usecase.dart';

class AuthBloc with ChangeNotifier {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Login with username and password
  void login() async {
    bool success = await loginUseCase.execute(
      usernameController.text,
      passwordController.text,
    );

    if (success) {
      // Handle success (Navigate, show success message)
    } else {
      // Handle failure
    }
  }

  // Login with Google
  void loginWithGoogle() async {
    bool success = await loginUseCase.executeWithGoogle();
    if (success) {
      // Handle Google sign-in success
    } else {
      // Handle failure
    }
  }
}