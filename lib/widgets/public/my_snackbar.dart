import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_colors.dart';
import '../../core/enum.dart';
import '../../core/utils.dart';
import 'my_text_widget.dart';

SnackbarController mySnackBar({
  String? message,
  Color? color,
  Icon? icon,
  Duration? duration,
}) {
  return Get.snackbar('', '',
      onTap: (snack) => Get.back(),
      messageText: Container(),
      duration: duration ?? const Duration(milliseconds: 1700),
      titleText: Container(),
      maxWidth: Get.width * .8,
      margin: EdgeInsets.only(bottom: 20),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 0,
      backgroundColor: AppColors.transparent,
      colorText: Colors.white,
      // margin: EdgeInsets.only(right: 20, left: 20),
      borderRadius: 60,
      userInputForm: Form(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) return;
          },
          child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: Utils.defaultTextDirection,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 5), child: icon ?? const SizedBox()),
                Flexible(
                  child: MyText(
                    fontSize: 16,
                    fontType: FontType.bold,
                    textDirection: Utils.defaultTextDirection,
                    textAlign: TextAlign.center,
                    // maxLines: 1,
                    // textOverflow: TextOverflow.ellipsis,
                    text: '$message',
                  ),
                ),
              ])));
}
