import 'dart:io';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          top: Platform.isAndroid,
          bottom: Platform.isAndroid,
          child: SizedBox()),
    );
  }
}
