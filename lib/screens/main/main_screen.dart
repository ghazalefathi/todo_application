import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/controller/main_controller.dart';
import '../../../core/app_colors.dart';
import '../../widgets/public/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final mainController = Get.find<MainController>();

  @override
  void initState() {
    mainController.animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200));
    mainController.blurAnimationController = Tween<double>(begin: 0, end: 10)
        .animate(mainController.animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.transparent,
        extendBody: true,
        bottomNavigationBar: BottomNavWidget(),
        body: Stack(children: [
          GetBuilder<MainController>(
              id: 'bottomNav',
              builder: (controller) {
                return Positioned.fill(
                    child: SafeArea(
                        child: AnimatedBuilder(
                            animation: controller.animationController,
                            builder: (context, child) {
                              return SizedBox.expand(
                                  child: Stack(children: [
                                Positioned.fill(
                                    child: Opacity(
                                        opacity: (1 -
                                            controller
                                                .animationController.value),
                                        child: SizedBox.expand(
                                            child: IndexedScreens(
                                                index: controller.mainBottomNav
                                                    .value.index))))
                              ]));
                            })));
              })
        ]));
  }
}
