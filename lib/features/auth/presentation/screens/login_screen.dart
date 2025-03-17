import 'package:flutter/material.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthBloc>(
          builder: (context, authBloc, child) {
            return Column(
              children: [
                TextField(
                  controller: authBloc.usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: authBloc.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                ElevatedButton(
                  onPressed: () {
                    authBloc.login();
                  },
                  child: Text('Login with Username'),
                ),
                ElevatedButton(
                  onPressed: () {
                    authBloc.loginWithGoogle();
                  },
                  child: Text('Login with Google'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}