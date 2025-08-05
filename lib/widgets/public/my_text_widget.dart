import 'package:flutter/material.dart';
import 'package:todo_application/core/extentions.dart';
import '../../core/app_colors.dart';
import '../../core/enum.dart';
import '../../core/strings.dart';
import '../../core/utils.dart';

class MyText extends StatelessWidget {
  const MyText({
    this.color,
    this.bgColor,
    this.fontSize,
    this.shadows,
    this.textAlign,
    this.textDirection,
    this.textOverflow,
    this.fontWeight,
    this.padding,
    this.maxLines,
    this.lineHeight,
    this.toReadable,
    this.fontType,
    this.opacity,
    this.foreground,
    this.textDecoration = TextDecoration.none,
    required this.text,
    super.key, this.decorationColor,
  });
  final Color? color;
  final Color? bgColor;
  final String text;
  final Color ? decorationColor;
  final double? fontSize;
  final double? lineHeight;
  final double? opacity;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? textOverflow;
  final List<Shadow>? shadows;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final bool? toReadable;
  final FontType? fontType;
  final Paint? foreground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        toReadable == true ? text.toReadable() : text,
        textScaler: const TextScaler.linear(1),
        maxLines: maxLines,
        overflow: textOverflow,
        textDirection: textDirection ?? Utils.defaultTextDirection,
        textAlign: textAlign ?? Utils.defaultTextAlign,
        style: TextStyle(
          decorationColor: decorationColor,
          
          foreground: foreground,
          height: lineHeight,
          color: foreground != null ? null : (color ?? AppColors.white),
          fontSize: fontSize ?? 14,
          shadows: shadows,
          fontWeight: fontWeight,
          decoration: textDecoration,
          fontFamilyFallback: [
            MyStrings.getFonts(
                fontType: fontType ?? FontType.regular)
          ],
          fontFamily: MyStrings.getFonts(
              fontType: fontType ?? FontType.regular),
        ),
      ),
    );
  }
}
