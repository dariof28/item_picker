import 'package:flutter/material.dart';

class TextStyles {
  static const _semiBold = FontWeight.w600;

  /// The default style for selected [SwitchItem]
  static selectedSwitchItemLabel(Color color) => TextStyle(
        color: color,
        fontSize: 16.0,
        fontWeight: _semiBold,
      );

  /// The default style for unselected [SwitchItem]
  static switchItemLabel([Color color, FontWeight fontWeight]) => TextStyle(
        color: color ?? Colors.black,
        fontSize: 16.0,
        fontWeight: fontWeight,
      );
}
