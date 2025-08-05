import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_application/core/extentions.dart';
import '../../core/app_colors.dart';
import '../../core/enum.dart';
import '../../core/strings.dart';
import 'my_text_field.dart';

class CustomPinput extends StatelessWidget {
  const CustomPinput({
    super.key,
    required this.codeController,
    this.onchangedAction,
    this.enabled,
    this.width,
    this.height,
    this.shadow,
    this.borderColor,
    this.focusedBorderColor, this.length, this.backgroundColor,
  });

  final TextEditingController codeController;
  final Function(String text)? onchangedAction;
  final bool? enabled;
  final double? width;
  final double? height;
  final BoxShadow? shadow;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final int ? length;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      
        enabled: enabled ?? true,
        
        controller: codeController,
        length: length ??  4,
        inputFormatters: [NumberOnlyFormatter()],
        focusedPinTheme: PinTheme(
            margin: EdgeInsets.symmetric(horizontal: 2.5),
            textStyle: TextStyle(color: AppColors.white, fontSize: 24,fontFamily: MyStrings.getFonts(fontType: FontType.semiBold)),
            padding: EdgeInsets.symmetric(horizontal: context.standard2x),
            width: width ?? (context.appWidth / 3.8) - 35,
            height: height ?? (context.appWidth / 4) - 35,
            decoration: BoxDecoration(
                boxShadow: shadow == null ? [] : [shadow!],
                border: Border.all(
                    color: focusedBorderColor ?? AppColors.error, width: 2),
                color: backgroundColor ??  AppColors.white,
                borderRadius: BorderRadius.circular(12))),
        defaultPinTheme: PinTheme(
            margin: EdgeInsets.symmetric(horizontal: 2.5),
            textStyle: TextStyle(color: AppColors.white, fontSize: 24,fontFamily: MyStrings.getFonts(fontType: FontType.semiBold)),
            padding: EdgeInsets.symmetric(horizontal: context.standard2x),
            width: width ?? (context.appWidth / 3.8) - 35,
            height: height ?? (context.appWidth / 4) - 35,
            decoration: BoxDecoration(
                border: Border.all(color: borderColor ?? AppColors.border),
                boxShadow: shadow == null
                    ? []
                    : [
                        BoxShadow(
                            color: AppColors.black.withValues(alpha: .5),
                            blurRadius: 2,
                            spreadRadius: .04,
                            offset: Offset(0, 2))
                      ],
                color: backgroundColor ??  AppColors.white,
                borderRadius: BorderRadius.circular(12))),
        showCursor: false,
        onChanged: onchangedAction);
  }
}
