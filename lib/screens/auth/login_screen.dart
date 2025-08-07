import 'package:flutter/material.dart';
import 'package:todo_application/core/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              stops: [.05, .4],
              end: Alignment.topLeft,
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ])),
              child: Container(),
    ));
  }
}
