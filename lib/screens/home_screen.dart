import 'package:flutter/material.dart';
import 'package:todo_application/core/assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          Assets.bgHome,
          fit: BoxFit.cover,
        ))
      ],
    ));
  }
}
