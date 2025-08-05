import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/app_colors.dart';

class CustomShimmerWidget extends StatelessWidget {
  const CustomShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.borderRadius,
    this.duration,
    this.boxDecoration,
    this.margin,
    this.baseColor,
    this.highlightColor,
    this.bgColor,
  });

  final double? width;
  final double? height;
  final double? radius;
  final Duration? duration;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? bgColor;
  final BoxDecoration? boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: duration ?? Duration(seconds: 1),
      baseColor: baseColor == null
          ? AppColors.white.withValues(alpha: .5)
          : baseColor!,
      highlightColor: highlightColor ?? Colors.grey,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: bgColor ?? Colors.grey.withValues(alpha: .2),
            borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 4)),
      ),
    );
  }
}
