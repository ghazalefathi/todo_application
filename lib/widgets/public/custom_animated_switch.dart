import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/utils.dart';

class CustomAnimatedSwitch extends StatelessWidget {
  const CustomAnimatedSwitch(
      {required this.value, this.onTap, this.activeBackgroundColor, super.key});
  final Color? activeBackgroundColor;
  final Function()? onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
          Utils.vibrate();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 55,
        height: 28,
        padding: EdgeInsets.symmetric(horizontal: 2.5),
        alignment: value ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
        decoration: BoxDecoration(
            color: value ? activeBackgroundColor ?? AppColors.blue : Color(0xffDADADA),
            borderRadius: BorderRadius.circular(50)),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
