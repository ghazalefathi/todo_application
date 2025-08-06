import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/core/app_colors.dart';
import 'package:todo_application/core/enum.dart';
import 'package:todo_application/core/extentions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_application/controller/main_controller.dart';
import '../../core/assets.dart';
import '../../widgets/public/my_text_button.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  State<BottomNavWidget> createState() => BottomNavWidgetState();
}

class BottomNavWidgetState extends State<BottomNavWidget> {
  final controller = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
          height: 65 + context.bottomSafeArea,
          padding: EdgeInsets.only(
              left: 20, right: 20, bottom: context.bottomSafeArea, top: 5),
          width: context.appWidth,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: .5,
                  color: AppColors.black.withValues(alpha: .15),
                  offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Color.fromARGB(255, 6, 1, 31),
          ),
          child: GetBuilder<MainController>(
              init: MainController(),
              initState: (_) {},
              id: 'bottomNav',
              builder: (_) {
                return Row(
                    children:
                        List.generate(BottomNavEnum.values.length, (index) {
                  // if (BottomNavEnum.values[index] == BottomNavEnum.home) {
                  //   return MyTextButton(
                  //       bgColor: AppColors.transparent,
                  //       width: 60,
                  //       height: 60,
                  //       onTap: () => controller.changeScreen(
                  //           bottomNav: BottomNavEnum.values[index]),
                  //       child: SizedBox.square(
                  //           dimension: 60,
                  //           child: Image.asset(Assets.)));
                  // }
                  bool isActive = controller.mainBottomNav.value ==
                      BottomNavEnum.values[index];
                  return Expanded(
                      child: GestureDetector(
                          onTap: () => controller.changeScreen(
                              bottomNav: BottomNavEnum.values[index]),
                          child: AnimatedScale(
                              duration: Duration(milliseconds: 200),
                              scale: isActive ? 1.1 : 1,
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Positioned.fill(
                                    top: -20,
                                    child: MyTextButton(
                                        bgColor: AppColors.transparent,
                                        onTap: () {
                                          controller.changeScreen(
                                              bottomNav:
                                                  BottomNavEnum.values[index]);
                                        },
                                        padding: EdgeInsets.zero,
                                        child: SvgPicture.asset(
                                            width: 21,
                                            height: 21,
                                            Assets.bottomNavIcons(
                                              BottomNavEnum.values[index],
                                            ),
                                            colorFilter: ColorFilter.mode(
                                                isActive
                                                    ? AppColors.blue
                                                    : AppColors.white,
                                                BlendMode.srcIn)))),
                              ]))));
                }));
              })),
    );
  }
}


class IndexedScreens extends StatefulWidget {
  const IndexedScreens({super.key, required this.index});
  final int index;

  @override
  State<IndexedScreens> createState() => IndexedScreensState();
}

class IndexedScreensState extends State<IndexedScreens> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: widget.index, children: [SizedBox(),SizedBox(),SizedBox()]);
  }
}