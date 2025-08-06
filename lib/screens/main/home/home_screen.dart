import 'package:flutter/material.dart';
import 'package:todo_application/core/app_colors.dart';
import 'package:todo_application/core/assets.dart';
import 'package:todo_application/core/extentions.dart';
import 'package:todo_application/widgets/public/my_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomeBackground(
            child: Column(
                children: [CityWeather(), Image.asset(Assets.imgHome)])));
  }
}

class HomeBackground extends StatelessWidget {
  const HomeBackground({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Positioned.fill(child: Image.asset(Assets.bgHome, fit: BoxFit.cover)),
      Positioned.fill(top: context.topSafeArea, child: child)
    ]);
  }
}

class CityWeather extends StatelessWidget {
  const CityWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MyText(text: 'Montreal', fontSize: 20),
      MyText(
        text: '19°',
        fontSize: 40,
      ),
      MyText(
        text: 'Mostly Clear',
        color: AppColors.labelDarkSecondary,
      ),
      MyText(text: 'H:24° L:18°'),
    ]);
  }
}
