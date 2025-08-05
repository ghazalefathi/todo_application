import 'package:flutter/material.dart';

import '../../core/enum.dart';
import '../../core/utils.dart';
import 'my_text_widget.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    this.title,
    this.textField,
    this.isDistanceFromBottom,
  });
  final String? title;
  final Widget? textField;
  final bool? isDistanceFromBottom;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: Utils.defaultTextDirection,
      children: [
        if (title != null)
          MyText(
            text: title ?? '',
            fontType: FontType.medium,
            fontSize: 15,
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
        textField ?? SizedBox(),
        if (isDistanceFromBottom == true)
          SizedBox(
            height: 10,
          ),
      ],
    );
  }
}
