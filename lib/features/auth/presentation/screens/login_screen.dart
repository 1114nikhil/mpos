import 'package:flutter/material.dart';
import 'package:mpos/core/utils/responsive_utils.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:mpos/features/auth/presentation/widget/login_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get responsive configurations
    final config = ResponsiveUtils.getResponsiveConfig(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: config.maxContentWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: config.padding),
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(config.padding),
                          child: Consumer<AuthBloc>(
                            builder: (context, authBloc, child) {
                              return LoginForm(
                                authBloc: authBloc,
                                fontSizeMultiplier: config.fontSizeMultiplier,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}