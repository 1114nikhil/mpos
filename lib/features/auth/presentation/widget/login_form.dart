import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:mpos/core/widgets/ult_text_field.dart';
import 'package:mpos/core/widgets/ult_elevated_button.dart';
import 'package:mpos/core/widgets/ult_outlined_button.dart';

class LoginForm extends StatelessWidget {
  final AuthBloc authBloc;
  final double fontSizeMultiplier;
  final double padding;

  const LoginForm({
    super.key,
    required this.authBloc,
    this.fontSizeMultiplier = 1.0,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign In",
          style: GoogleFonts.poppins(
            fontSize: 28 * fontSizeMultiplier,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF00C4B4), // Sky Blue
          ),
        ),
        SizedBox(height: padding / 2),
        Text(
          "Welcome back to your account",
          style: GoogleFonts.poppins(
            fontSize: 14 * fontSizeMultiplier,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: padding * 2),
        ULTTextField(
          controller: authBloc.usernameController,
          hintText: 'Username',
          fontSizeMultiplier: fontSizeMultiplier,
        ),
        SizedBox(height: padding),
        ULTTextField(
          controller: authBloc.passwordController,
          hintText: 'Password',
          obscureText: true,
          fontSizeMultiplier: fontSizeMultiplier,
        ),
        SizedBox(height: padding * 1.5),
        ULTElevatedButton(
          onPressed: () => authBloc.login(context),
          text: 'Login',
          fontSizeMultiplier: fontSizeMultiplier,
        ),
        SizedBox(height: padding),
        Center(
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 14 * fontSizeMultiplier,
              color: Colors.grey[500],
            ),
          ),
        ),
        SizedBox(height: padding),
        ULTOutlinedButton(
          onPressed: () => authBloc.loginWithGoogle(context),
          text: 'Continue with Google',
          iconPath: 'assets/images/google_logo.png',
          fontSizeMultiplier: fontSizeMultiplier,
        ),
      ],
    );
  }
}