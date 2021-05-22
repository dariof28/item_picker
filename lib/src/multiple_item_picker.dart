import 'package:flutter/material.dart';

import 'styles.dart';
import 'switch_item.dart';

/// This widget render as many list entries as many [list] map entries you provide.
/// More than one item can be selected.
class MultipleItemPicker<T> extends StatefulWidget {
  final ScrollPhysics? physics;

  /// Define the key value for each item. The key will be used as item label
  /// while the value will be inserted in the [selectedValues] on the state when selected
  /// and removed when unselected.
  final List<MapEntry<String, T>> list;

  /// The entry to be used to reset the selection. This entry will be rendered on top on the list.
  /// Once pressed it will clear the current selection
  final MapEntry<String, T>? resetOption;

  /// The styles for each entry. This list should match one to one with the [list] items.
  final List<TextStyle>? itemStyles;

  /// The style for the reset option entry
  final TextStyle? resetOptionStyle;

  /// The options to be selected by default
  final List<T> defaultValues;

  /// You can provide a custom marker to mark an entry as selected.
  /// By default the entry is marked with a [Icons.check]
  final Widget? selectedMarker;

  /// Separator for each entry of the list.
  final Widget separator;

  final ValueChanged<T> onItemSelect;

  final ValueChanged<T> onItemUnSelect;

  final VoidCallback? onResetSelection;

  /// You can provide a custom marker to mark an entry as selected.
  /// By default the entry is marked with a [Icons.check]
  /// Callback to handle a new item selected
  /// Callback to handle an item remove
  /// Callback to handle the selection reset
  MultipleItemPicker({
    this.physics,
    required this.list,
    this.resetOption,
    this.itemStyles,
    this.resetOptionStyle,
    defaultValues,
    this.selectedMarker,
    separator,
    required this.onItemSelect,
    required this.onItemUnSelect,
    this.onResetSelection,
  })  : assert(
          itemStyles == null || itemStyles.length == list.length,
          "itemStyles should have as many entries as list",
        ),
        assert(
          resetOption == null || onResetSelection != null,
          "You must specify an onResetSelection callback if you add a resetOption",
        ),
        separator = separator ?? Container(),
        defaultValues = defaultValues ?? [];

  @override
  _MultipleItemPickerState<T> createState() => _MultipleItemPickerState<T>();
}

class _MultipleItemPickerState<T> extends State<MultipleItemPicker<T>> {
  List<T> selectedValues = [];

  @override
  void initState() {
    super.initState();
    selectedValues.addAll(widget.defaultValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _renderResetOption(),
        ListView.separated(
          shrinkWrap: true,
          physics: widget.physics,
          itemBuilder: (BuildContext context, int index) {
            MapEntry<String, T> item = widget.list[index];

            return InkWell(
              onTap: () {
                T newValue = item.value;

                setState(() {
                  if (!selectedValues.contains(newValue)) {
                    selectedValues.add(newValue);
                    widget.onItemSelect(newValue);
                  } else {
                    selectedValues.remove(newValue);
                    widget.onItemUnSelect(newValue);
                  }
                });
              },
              child: SwitchItem(
                label: item.key,
                labelStyle: widget.itemStyles != null
                    ? widget.itemStyles![index]
                    : TextStyles.switchItemLabel(),
                isSelected: selectedValues.contains(item.value),
                selectedMarker: widget.selectedMarker,
              ),
            );
          },
          separatorBuilder: (context, index) => widget.separator,
          itemCount: widget.list.length,
        ),
      ],
    );
  }

  Widget _renderResetOption() {
    if (widget.resetOption == null) {
      return Container();
    }

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              selectedValues.clear();
              widget.onResetSelection!();
            });
          },
          child: SwitchItem(
            label: widget.resetOption!.key,
            labelStyle: widget.resetOptionStyle != null
                ? widget.resetOptionStyle!
                : TextStyles.switchItemLabel(),
            isSelected: selectedValues.length == 0,
            selectedMarker: widget.selectedMarker,
          ),
        ),
        widget.separator,
      ],
    );
  }
}
