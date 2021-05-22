import 'package:flutter/material.dart';

import 'styles.dart';
import 'switch_item.dart';

/// This widget render as many list entries as many [list] map entries you provide.
class ItemPicker<T> extends StatefulWidget {
  /// Define the key value for each item. The key will be used as item label
  /// while the value will be returned from [onSelectionChange] callback every
  /// time the corresponding item is selected.
  final List<MapEntry<String, T>> list;

  ///A callback [onSelectionChange] to handle the new selected value.
  final ValueChanged<T> onSelectionChange;

  final ScrollPhysics? physics;

  /// The styles for each entry. This list should match one to one with the [list] items.
  final List<TextStyle>? itemStyles;

  /// This is the default selected value
  final T? defaultValue;

  /// You can provide a custom marker to mark an entry as selected.
  /// By default the entry is marked with a [Icons.check]
  final Widget? selectedMarker;

  /// Separator for each entry of the list.
  final Widget separator;

  ItemPicker({
    required this.list,
    required this.onSelectionChange,
    this.physics,
    this.itemStyles,
    this.defaultValue,
    this.selectedMarker,
    Widget? separator,
  })  : assert(
          itemStyles == null || itemStyles.length == list.length,
          "itemStyles should have as many entries as list",
        ),
        separator = separator ?? Container();

  @override
  _ItemPickerState<T> createState() => _ItemPickerState<T>();
}

class _ItemPickerState<T> extends State<ItemPicker<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: widget.physics,
      itemBuilder: (BuildContext context, int index) {
        MapEntry<String, T> item = widget.list[index];

        return InkWell(
          onTap: () {
            T newValue = item.value;

            if (newValue != selectedValue) {
              setState(() {
                selectedValue = newValue;
              });
              widget.onSelectionChange(newValue);
            }
          },
          child: SwitchItem(
            label: item.key,
            labelStyle: _switchItemStyle(index),
            isSelected: selectedValue == item.value,
            selectedMarker: widget.selectedMarker,
          ),
        );
      },
      separatorBuilder: (context, index) => widget.separator,
      itemCount: widget.list.length,
    );
  }

  TextStyle _switchItemStyle(int index) {
    if (widget.itemStyles == null) {
      return TextStyles.switchItemLabel();
    }

    return widget.itemStyles!.elementAt(index);
  }
}
