import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

Container generateDivider({double? width, double? height, Color? color, EdgeInsets? margin}) {
  return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 10),
      height: height ?? 1,
      width: width,
      color: color ?? AppColors.black.withValues(alpha: .07));
}
