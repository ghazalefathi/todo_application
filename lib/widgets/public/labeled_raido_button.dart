import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/utils.dart';
import 'my_text_widget.dart';

class LabeledRadioButton<T> extends StatelessWidget {
  const LabeledRadioButton({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    super.key,
  });
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: Utils.defaultTextDirection,
      children: [
        MyText(text: title, color: AppColors.white),
        Radio<T>(
            activeColor: AppColors.raidoButton,
            splashRadius: 5,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged)
      ],
    );
  }
}
