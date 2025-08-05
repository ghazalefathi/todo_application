import 'package:flutter/widgets.dart';
import 'app_colors.dart';

class Shadows {
  static BoxShadow generateBoxShadow({double blurRadius = 4, double alpha = .07}) => BoxShadow(
      blurStyle: BlurStyle.outer,
      color: AppColors.black.withValues(alpha: alpha),
      blurRadius: blurRadius);

  static BoxShadow get bs00 => generateBoxShadow();
  static BoxShadow get bsff => BoxShadow(
      blurStyle: BlurStyle.outer, color: AppColors.white.withValues(alpha: .2), blurRadius: 4);
  static BoxShadow get playerNameShadow => BoxShadow(
      offset: Offset(0, 3),
      color: AppColors.black.withValues(alpha: .2),
      spreadRadius: 0,
      blurRadius: 20);
  static BoxShadow get blackShadow00 => BoxShadow(
      blurRadius: 10,
      spreadRadius: .08,
      offset: Offset(0, 0),
      color: AppColors.black.withValues(alpha: .1));
}
