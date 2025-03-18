import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:mpos/core/widgets/ult_text_field.dart';
import 'package:mpos/core/widgets/ult_elevated_button.dart';
import 'package:mpos/core/widgets/ult_outlined_button.dart';

class LoginForm extends StatelessWidget {
  final AuthBloc authBloc;

  const LoginForm({required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign In",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00C4B4), // Sky Blue
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Welcome back to your account",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 32),
        ULTTextField(
          controller: authBloc.usernameController,
          hintText: 'Username',
        ),
        SizedBox(height: 16),
        ULTTextField(
          controller: authBloc.passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 24),
        ULTElevatedButton(
          onPressed: () => authBloc.login(context),
          text: 'Login',
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'or',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
        SizedBox(height: 16),
        ULTOutlinedButton(
          onPressed: () => authBloc.loginWithGoogle(context),
          text: 'Continue with Google',
          iconPath: 'assets/images/google_logo.png',
        ),
      ],
    );
  }
}