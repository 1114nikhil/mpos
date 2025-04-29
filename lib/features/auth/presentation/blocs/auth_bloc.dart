import 'package:flutter/material.dart';
import 'package:mpos/core/utils/responsive_utils.dart';
import 'package:mpos/core/widgets/ult_toaster.dart';
import 'package:mpos/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpos/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mpos/features/dashboard/presentation/widget/text_style.dart';

class AuthBloc with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc(this.loginUseCase, this.signUpUseCase);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _showToaster(BuildContext context, String message, ) {
    final config = ResponsiveUtils.getResponsiveConfig(context);
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ULTToaster(
        config: config,
        gradient: const LinearGradient(
        colors: [Color.fromARGB(255, 179, 40, 30), Color.fromARGB(255, 221, 103, 95)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
        autoDismissDuration: const Duration(seconds: 3),
        child: Text(
          message,
          style: textStyle(
            fontSize: 16,
            config: config,
            color: Colors.white,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void login(BuildContext context) async {
    try {
      bool success = await loginUseCase.execute(
        usernameController.text,
        passwordController.text,
      );

      if (success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showToaster(context, "Invalid Credentials");
      }
    } catch (e) {
      _showToaster(context, "An error occurred: $e");
    }
  }

  void signUp(BuildContext context) async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        _showToaster(context, "Passwords do not match");
        return;
      }

      bool success = await signUpUseCase.execute(
        usernameController.text,
        passwordController.text,
      );

      if (success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showToaster(context, "Sign Up failed");
      }
    } catch (e) {
      print(e.toString());
      _showToaster(context, "$e");
    }
  }

  void loginWithGoogle(BuildContext context) async {
    try {
      bool success = await loginUseCase.executeWithGoogle();
      if (success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showToaster(context, "Google Sign-In failed");
      }
    } catch (e) {
      _showToaster(context,  "$e");
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}