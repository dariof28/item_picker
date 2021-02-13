# item_picker

Item picker widgets package

## Features

### ItemPicker

A single item picker. This widget allows you to build a list of selectable item.

```dart
ItemPicker<int>(
    list: [
      MapEntry("One", 1),
      MapEntry("Two", 2),
      MapEntry("Three", 3),
    ],
    onSelectionChange: (value) {
      // do something with the new picked value
    },    
);
```
The `list` is made of MapEntry<String, T> where the key is the label to show on each item and the value is the value that will be picked on each entry tap

You can:
- customize the style of each List entry passing an `itemStyles` list of TextStyle
- set an optional `defaultValue` (by default no item is selected)
- customize the `selectedMarker` (by default a check icon is show on the right of the selected item)
- customize each item `separator` (by default no separator is shown)
