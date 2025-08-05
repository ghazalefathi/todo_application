import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/utils.dart';
import 'my_text_widget.dart';

class MyDropDownWidget extends StatelessWidget {
  const MyDropDownWidget({
    this.list,
    this.hintText,
    this.hintColor,
    this.backgroundColor,
    this.height,
    this.margin,
    this.isLoading,
    this.width,
    this.strokeColor,
    this.defaultPadding,
    this.radius,
    this.menuItemHeight,
    this.hintFontSize,
    this.padding,
    this.iconColor,
    this.menuItemBorderColor,
    this.dropdownBackgroundColor,
    this.strokeWidth,
    this.shadow,
    super.key,
    this.textDirectionIcon,
  });
  final List<DropdownMenuItem<Object?>>? list;
  final String? hintText;
  final Color? backgroundColor;
  final Color? hintColor;
  final double? hintFontSize;
  final Color? strokeColor;
  final Color? iconColor;
  final double? strokeWidth;
  final double? width;
  final double? height;
  final double? defaultPadding;
  final double? radius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool? isLoading;
  final double? menuItemHeight;
  final Color? menuItemBorderColor;
  final Color? dropdownBackgroundColor;
  final BoxShadow? shadow;
  final TextDirection? textDirectionIcon;
  // final Color? Color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 80,
      width: width,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        // isDense: true,
        customButton: Container(
          padding: padding,
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              boxShadow: shadow == null ? [] : [shadow!],
              color: backgroundColor ?? AppColors.white,
              border: Border.all(
                  width: strokeWidth ?? 1,
                  color: strokeColor ?? AppColors.border),
              borderRadius: BorderRadius.circular(radius ?? 10)),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: textDirectionIcon ?? Utils.defaultTextDirection,
            children: [
              SizedBox(
                width: defaultPadding ?? 10,
              ),
              Expanded(
                child: MyText(
                  text: hintText ?? '',
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  color: hintColor,
                  fontSize: hintFontSize,
                ),
              ),
              SizedBox.square(
                  dimension: 25,
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      color: iconColor ?? Colors.black)),
              SizedBox(width: defaultPadding ?? 10),
              // Row(children: [

              // ]),
              // Row(children: [
              // ]),
            ],
          ),
        ),
        isExpanded: true,
        buttonStyleData: ButtonStyleData(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          elevation: 1,
        ),

        menuItemStyleData: MenuItemStyleData(
            height: menuItemHeight ?? 40,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
        dropdownStyleData: DropdownStyleData(
            elevation: 0,
            maxHeight: 300,
            decoration: BoxDecoration(
                boxShadow: shadow == null ? [] : [shadow!],
                border: Border.all(
                    color: menuItemBorderColor ?? AppColors.border, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: dropdownBackgroundColor ?? AppColors.white)),
        onChanged: (value) {},
        items: list ?? [],
      )),
    );
  }
}
