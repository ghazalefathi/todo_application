import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/enum.dart';

class MainController extends GetxController {
  late AnimationController animationController;
  late Animation<double> blurAnimationController;
  Rx<BottomNavEnum> mainBottomNav = BottomNavEnum.home.obs;

  void changeScreen({required BottomNavEnum bottomNav}) {
    animationController
        .forward(from: bottomNav == mainBottomNav.value ? 1 : 0)
        .then(
      (value) {
        animationController.reverse(
            from: bottomNav == mainBottomNav.value ? 0 : 1);

        mainBottomNav(bottomNav);

        switch (bottomNav) {
          case BottomNavEnum.home:
            break;
          case BottomNavEnum.menu:
            break;
          case BottomNavEnum.location:
            break;
        }
        update(['bottomNav']);
      },
    );
  }
}
