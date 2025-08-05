import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import 'my_text_button.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MyTextButton(
      onTap: () => Get.back(),
        bgColor: AppColors.primary200,
        radius: 50,
        width: 30,
        height: 30,
        child: Icon(Icons.close_rounded));
  }
}
