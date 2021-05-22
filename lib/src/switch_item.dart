import 'package:flutter/material.dart';

import 'styles.dart';

/// This is the base component for the list building.
/// You probably won't need to directly use this widget.
class SwitchItem extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;
  final bool isSelected;
  final Widget? selectedMarker;

  SwitchItem({
    required this.label,
    this.isSelected = false,
    required this.labelStyle,
    this.selectedMarker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: isSelected
                  ? TextStyles.selectedSwitchItemLabel(labelStyle.color)
                  : labelStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Visibility(
            visible: isSelected,
            child: selectedMarker ?? Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
