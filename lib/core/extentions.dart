import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  double get appWidth => MediaQuery.of(this).size.width;
  double get appHeight => MediaQuery.of(this).size.height;
  double get bottomSafeArea => MediaQuery.of(this).viewPadding.bottom;
  double get bottoms => MediaQuery.of(this).viewInsets.bottom;
  double get topSafeArea => MediaQuery.of(this).viewPadding.top;
  double get standard => 8;
  double get standard2x => 16;
  double get standard3x => 32;
  double get standard4x => 64;
}

extension HumanReadable on String {
  String toReadable() {
    if (isEmpty || this == '') return '';

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return replaceAllMapped(reg, mathFunc);
  }



}
