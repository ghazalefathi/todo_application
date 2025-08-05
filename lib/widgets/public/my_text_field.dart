// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_application/core/extentions.dart';
import '../../core/app_colors.dart';
import '../../core/enum.dart';
import '../../core/regexes.dart';
import '../../core/strings.dart';
import '../../core/utils.dart';
import 'my_text_widget.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    this.hint,
    this.isReadble,
    this.labelColor,
    this.controller,
    this.borderRadius,
    this.inputType,
    this.maxLength,
    this.textAlign,
    this.action,
    this.onchangedAction,
    this.focusNode,
    this.maxLines = 1,
    this.textDirection,
    this.isPassword,
    this.isEnabled,
    this.hintColor,
    this.hintFontSize,
    this.width,
    this.height,
    this.prefixIcon,
    this.hasBorder = false,
    this.textStyle,
    this.suffixIcon,
    this.cursorColor,
    // this.onActionClicked,
    this.fillColor,
    this.textColor,
    this.strokeColor,
    this.fontSize,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.autofocus,
    this.border,
    this.suggest,
    this.isExpands,
    this.margin,
    this.nullMaxLine,
    this.labelText,
    this.labelDirection,
    this.floatingLabelBehavior,
    this.labelFontSize,
    this.onTap,
    this.disableColor,
    this.prefixIconSize,
    this.shadow,
    this.errorStyle,
    this.validator,
    this.fontType,
    this.isEmail = false,
    super.key,
    this.textInputFormatter,
  });
  final bool? isReadble;
  final String? hint;
  final String? labelText;
  final double? borderRadius;
  final double? hintFontSize;
  final double? labelFontSize;
  final double? width;
  final double? height;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? paddingRight;
  final double? fontSize;
  final double? prefixIconSize;
  TextEditingController? controller;
  final TextInputType? inputType;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextStyle? errorStyle;
  final TextInputAction? action;
  final Function(String text)? onchangedAction;
  // final Function(String text)? onActionClicked;
  final Function()? onTap;
  FocusNode? focusNode;
  final int? maxLines;
  final TextDirection? textDirection;
  final TextDirection? labelDirection;
  final bool? isPassword;
  final bool? isEnabled;
  final bool? hasBorder;
  final bool? autofocus;
  final bool? suggest;
  final bool? nullMaxLine;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? strokeColor;
  final Color? fillColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? disableColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final bool? isExpands;
  final EdgeInsets? margin;
  final List<TextInputFormatter>? textInputFormatter;
  final FontType? fontType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final BoxShadow? shadow;
  final String? Function(String?)? validator;
  final bool isEmail;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode focusNode;
  @override
  void initState() {
    widget.controller ??= TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    if (widget.onTap != null && widget.focusNode == null) {
      throw ErrorDescription('ontap and focusNode cant be null at the same time');
    }
    if (widget.isReadble == true && widget.controller == null) {
      throw ErrorDescription('isReadble and controller cant be null at the same time');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
          boxShadow: widget.shadow == null ? [] : [widget.shadow!],
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 16)),
      // decoration: BoxDecoration(
      //     boxShadow: widget.shadow == null ? [] : [widget.shadow!],
      //     color: widget.fillColor ?? Theme.of(context).canvasColor,
      //     borderRadius: BorderRadius.circular(widget.borderRadius ?? 10)),
      child: IntrinsicHeight(
        child: Directionality(
          textDirection: widget.labelDirection ?? Utils.defaultTextDirection,
          child: SizedBox.expand(
            child: TextFormField(
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                  focusNode.requestFocus();
                }
              },

              expands: widget.isExpands == true,
              enableSuggestions: widget.suggest ?? false,
              autocorrect: widget.suggest ?? false,
              autofocus: widget.autofocus ?? false,
              enabled: widget.isEnabled,
              obscureText: widget.isPassword == true,
              focusNode: focusNode,
              textInputAction: widget.action,
              maxLines: widget.nullMaxLine == true ? null : widget.maxLines,
              style: widget.textStyle ??
                  TextStyle(
                      color: widget.textColor ?? AppColors.white,
                      fontFamilyFallback: [
                        MyStrings.getFonts(
                          fontType: widget.fontType ?? FontType.regular,
                        )
                      ],
                      fontFamily: MyStrings.getFonts(
                        fontType: widget.fontType ?? FontType.regular,
                      ),
                      fontSize: widget.fontSize ?? 14,
                      letterSpacing: 0),
              textDirection: widget.textDirection ?? Utils.defaultTextDirection,
              keyboardType: widget.inputType,

              // onSubmitted: widget.onActionClicked,
              validator: widget.validator,
              onTapOutside: (event) {
                focusNode.unfocus();
              },
              controller: widget.controller,
              readOnly: widget.onTap != null,
              onChanged: (txt) {
                if (widget.onchangedAction != null) {
                  widget.onchangedAction!(txt);
                }
                if (widget.isReadble == true) {
                  String a = txt.replaceAll(',', '');
                  widget.controller!.text = a.toReadable();
                }
              },

              // validator: widget.validator,
              cursorColor: widget.cursorColor ?? AppColors.white.withValues(alpha: .5),
              textAlign: widget.textAlign ?? Utils.defaultTextAlign,
              inputFormatters: addlist(
                  widget.maxLength, widget.inputType, widget.textInputFormatter,
                  isEmail: widget.isEmail),
              decoration: InputDecoration(
                // labelText: labelText,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                // floatingLabelStyle: TextStyle(
                //     height: 1,
                //     color: hintColor,
                //     fontSize: labelFontSize ?? 15,
                //     fontFamily: Strings().fontNormal),
                fillColor: widget.fillColor ?? AppColors.transparent,
                prefixIcon: widget.prefixIcon == null
                    ? null
                    : SizedBox.square(
                        dimension: widget.prefixIconSize ?? 30,
                        child: Center(child: widget.prefixIcon),
                      ),
                suffixIcon: widget.suffixIcon,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.only(
                  left: widget.paddingLeft ?? 15,
                  right: widget.paddingRight ?? 15,
                  top: widget.paddingTop ??
                      (widget.floatingLabelBehavior == FloatingLabelBehavior.always ? 15 : 15),
                  bottom: widget.paddingBottom ??
                      (widget.floatingLabelBehavior == FloatingLabelBehavior.always ? 15 : 15),
                ),
                alignLabelWithHint: true,

                label: widget.labelText == null
                    ? null
                    : MyText(
                        text: widget.labelText!,
                        fontSize: widget.labelFontSize ?? 14,
                        opacity: .5,
                        color: widget.labelColor ?? AppColors.white),
                // labelStyle: TextStyle(
                //     // height: 2,
                //     color: hintColor,
                //     fontFamily: Strings().fontNormal),
                hintText: widget.hint,
                hintStyle: TextStyle(
                    height: 1,
                    color: widget.hintColor ?? AppColors.hint,
                    fontSize: widget.hintFontSize ?? 14,
                    fontFamilyFallback: [
                      MyStrings.getFonts(
                        fontType: widget.fontType ?? FontType.regular,
                      )
                    ],
                    fontFamily: MyStrings.getFonts(
                      fontType: widget.fontType ?? FontType.regular,
                    )),

                border: InputBorder.none,

                errorBorder: widget.hasBorder == false
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? 16,
                        ),
                        borderSide: BorderSide(color: AppColors.error, width: 1))
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
                        borderSide:
                            BorderSide(color: widget.fillColor ?? AppColors.error, width: 1)),

                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 16,
                    ),
                    borderSide: BorderSide(color: AppColors.error, width: 1)),

                errorStyle: widget.errorStyle ??
                    TextStyle(
                      color: AppColors.textError,
                      height: 1.5,
                      fontFamily: MyStrings.getFonts(
                        fontType: widget.fontType ?? FontType.regular,
                      ),
                      fontSize: 12,
                    ),

                enabledBorder: widget.hasBorder == false
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? 16,
                        ),
                        borderSide: BorderSide(color: AppColors.border, width: 1))
                    : widget.border ??
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 16,
                            ),
                            borderSide: BorderSide(color: AppColors.border, width: 1)),
                focusedBorder: widget.hasBorder == false
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? 16,
                        ),
                        borderSide: BorderSide(color: AppColors.border, width: 1))
                    : widget.border ??
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
                            borderSide: BorderSide(color: AppColors.border, width: 1)),
                disabledBorder: widget.hasBorder == false
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? 16,
                        ),
                        borderSide: BorderSide(color: AppColors.border, width: 1))
                    : widget.border ??
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 16,
                            ),
                            borderSide: BorderSide(color: AppColors.border, width: 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<TextInputFormatter> addlist(
    int? length, TextInputType? txtinput, List<TextInputFormatter>? inputFormatters,
    {bool isEmail = false}) {
  List<TextInputFormatter> a = [];
  a.addAll(inputFormatters ?? []);
  if (length != null) {
    a.add(LengthLimitingTextInputFormatter(length));
  }
  if (txtinput == TextInputType.number) {
    a.add(NumberOnlyFormatter());
  }
  if (isEmail) {
    a.add(EmailFormatter());
  }
  return a;
}

class EmailFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    text = text.replaceAll(Regexes.invalidEmail, '');
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class NumberOnlyFormatter extends TextInputFormatter {
  // Matches any Persian or Arabic-Indic digit
  static final _persianArabicDigitRegex = RegExp(r'[\u06F0-\u06F9\u0660-\u0669]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // 1) Convert any Persian/Arabic-Indic digit to its Latin equivalent
    text = text.replaceAllMapped(_persianArabicDigitRegex, (match) {
      final codeUnit = match.group(0)!.codeUnitAt(0);
      if (codeUnit >= 0x06F0 && codeUnit <= 0x06F9) {
        return String.fromCharCode(codeUnit - 0x06F0 + 0x30);
      }
      return String.fromCharCode(codeUnit - 0x0660 + 0x30);
    });

    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
