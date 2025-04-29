import 'package:flutter/material.dart';
import 'package:mpos/features/auth/data/repositories/auth_repository.dart';
import 'package:mpos/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpos/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mpos/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository()),
        Provider(create: (context) => LoginUseCase(context.read<AuthRepository>())),
        Provider(create: (context) => SignUpUseCase(context.read<AuthRepository>())),
        ChangeNotifierProvider(
          create: (context) => AuthBloc(
            context.read<LoginUseCase>(),
            context.read<SignUpUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}