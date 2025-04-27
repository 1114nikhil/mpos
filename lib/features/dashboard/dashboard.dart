import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget{
  // const DashboardScreen({Key? key}) : super(key: key);
   const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard'),
      ),
      body: const Center(
        child: Text("Welcome to Dashboard"),
      ),
    );
  }
}