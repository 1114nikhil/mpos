import 'package:flutter/material.dart';
import 'package:mpos/features/auth/presentation/screens/login_screen.dart';
import 'package:mpos/features/dashboard/presentation/screen/dashboard.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings setting){
    switch (setting.name){
      case "/":
        return MaterialPageRoute(builder: (_)=>const LoginScreen());
      case "/dashboard":
        return MaterialPageRoute(builder: (_)=>const DashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${setting.name}')),
          ),
        );
    }
  }
}
