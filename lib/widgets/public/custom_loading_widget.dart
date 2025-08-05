import 'package:flutter/cupertino.dart';
import '../../core/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    this.size,
    this.color,
    super.key,
  });
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size ?? 15,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CupertinoActivityIndicator(
            color: color ?? AppColors.black),
      ),
    );
  }
}
