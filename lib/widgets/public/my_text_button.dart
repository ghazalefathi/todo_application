import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class MyTextButton extends StatefulWidget {
  const MyTextButton({
    this.width,
    this.margin,
    this.height,
    this.onTap,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
    this.radius,
    this.padding,
    this.boxShadow,
    this.bgGradient,
    required this.child,
    this.alignment,
    this.borderRadius,
    this.boxDecoration,
    this.border,
    super.key,
  });

  final Function()? onTap;
  final Widget child;
  final Color? bgColor;
  final Color? borderColor;
  final double? radius;
  final double? width;
  final double? height;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxShadow? boxShadow;
  final LinearGradient? bgGradient;
  final Alignment? alignment;
  final BorderRadius? borderRadius;
  final Border? border;
  final BoxDecoration? boxDecoration;

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  bool isPressed = false;

  void _onPressed(bool isPressed, {bool? needToBack}) {
    this.isPressed = isPressed;
    setState(() {});
    if (needToBack == true && mounted) {
      Timer(
        Duration(milliseconds: 80),
        () {
          this.isPressed = false;
          if (mounted) {
            setState(() {});
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        clipBehavior: Clip.none,
        margin: widget.margin,
        width: widget.width,
        height: widget.height ?? 55,
        child: GestureDetector(
          onTap: widget.onTap == null
              ? null
              : () {
                  widget.onTap!();
                  _onPressed(true, needToBack: true);
                },
          onTapDown: (details) {
            if (widget.onTap != null) {
              _onPressed(true);
            }
          },
          onTapUp: (details) {
            if (widget.onTap != null) {
              _onPressed(false);
            }
          },
          onTapCancel: () {
            if (widget.onTap != null) {
              _onPressed(false);
            }
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 80),
            opacity: isPressed ? .5 : 1,
            child: Container(
              clipBehavior: Clip.none,
              alignment: widget.alignment ?? Alignment.center,
              padding: widget.padding ?? EdgeInsets.zero,
              decoration: widget.boxDecoration ??
                  BoxDecoration(
                    color: widget.bgColor ?? AppColors.transparent,
                    gradient: widget.bgGradient,
                    boxShadow: widget.boxShadow == null ? [] : [widget.boxShadow!],
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 32),
                    border: widget.border ??
                        Border.all(
                            width: widget.borderWidth ?? 0,
                            color: widget.borderColor ?? Colors.transparent),
                  ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
