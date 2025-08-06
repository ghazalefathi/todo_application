import 'package:flutter/material.dart';
import 'package:todo_application/core/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AuthBackground());
  }
}

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColors.primary,
              AppColors.primary,
            ])),
      )),
      // Positioned.fill(
      //     top: 200,
      //     right: context.standard2x,
      //     left: context.standard2x,
      //     bottom: 200,
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //       child: Container(
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: const Color.fromARGB(255, 42, 38, 38).withValues(alpha: .5)),
      //           child: child),
      //     ))
    ]);
  }
}
