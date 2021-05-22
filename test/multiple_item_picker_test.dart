import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_picker/item_picker.dart';
import 'package:item_picker/src/styles.dart';
import 'package:item_picker/src/switch_item.dart';

main() {
  testWidgets(
      'Multiple item picker should have as many styles as many entries provided',
      (WidgetTester tester) async {
    List<MapEntry<String, int>> _entries = [
      MapEntry("one", 1),
      MapEntry("two", 2),
      MapEntry("three", 3),
    ];

    List<TextStyle> _styles = [
      TextStyle(),
      TextStyle(),
    ];

    expect(
      () => MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        itemStyles: _styles,
      ),
      throwsAssertionError,
    );
  });

  testWidgets(
    'Render as many SwitchItem as many entries provided',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.byType(SwitchItem), findsNWidgets(3));
    },
  );

  testWidgets(
    'Each SwitchItem should show the right label',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate1 =
          (Widget widget) => widget is SwitchItem && widget.label == "one";

      WidgetPredicate predicate2 =
          (Widget widget) => widget is SwitchItem && widget.label == "two";

      WidgetPredicate predicate3 =
          (Widget widget) => widget is SwitchItem && widget.label == "three";

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
    },
  );

  testWidgets(
    'Render reset option',
    (WidgetTester tester) async {
      final widget = MultipleItemPicker<int?>(
        list: [],
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        onResetSelection: () {},
        resetOption: MapEntry("reset", null),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicateReset =
          (Widget widget) => widget is SwitchItem && widget.label == "reset";

      expect(find.byWidgetPredicate(predicateReset), findsOneWidget);
    },
  );

  testWidgets('OnReset callback should be provided if resetOption is provided',
      (WidgetTester tester) async {
    expect(
      () => MultipleItemPicker<int?>(
        list: [],
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        resetOption: MapEntry("reset", null),
      ),
      throwsAssertionError,
    );
  });

  testWidgets(
    'Default values should be selected if provided',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        defaultValues: [1, 3],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.isSelected == false;

      WidgetPredicate predicateOther = (Widget widget) =>
          widget is SwitchItem &&
          widget.label != "two" &&
          widget.isSelected == true;

      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicateOther), findsNWidgets(2));
    },
  );

  testWidgets(
    'Reset option should be selected if provided and no default values are provided',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int?>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        onResetSelection: () {},
        resetOption: MapEntry("reset", null),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicateReset = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "reset" &&
          widget.isSelected == true;

      WidgetPredicate predicateOther = (Widget widget) =>
          widget is SwitchItem &&
          widget.label != "reset" &&
          widget.isSelected == false;

      expect(find.byWidgetPredicate(predicateReset), findsOneWidget);
      expect(find.byWidgetPredicate(predicateOther), findsNWidgets(3));
    },
  );

  testWidgets(
    'Selected item should show given marker',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final marker = Container(
        width: 10,
        height: 10,
        color: Colors.red,
      );

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        defaultValues: [1, 3],
        selectedMarker: marker,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is Visibility &&
          widget.visible == false &&
          widget.child == marker;

      WidgetPredicate predicateOther = (Widget widget) =>
          widget is Visibility &&
          widget.visible == true &&
          widget.child == marker;

      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicateOther), findsNWidgets(2));
    },
  );

  testWidgets(
    'Show default marker if no marker is provided',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        defaultValues: [1, 3],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate2 =
          (Widget widget) => widget is Visibility && widget.visible == false;

      WidgetPredicate predicateOther =
          (Widget widget) => widget is Visibility && widget.visible == true;

      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNWidgets(2));
      expect(find.byWidgetPredicate(predicateOther), findsNWidgets(2));
    },
  );

  testWidgets(
    'Should render n-1 given separators',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final separator = Container(height: 2.0, color: Colors.orange);

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        separator: separator,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.byWidget(separator), findsNWidgets(2));
    },
  );

  testWidgets(
    'Select item executes selection callback',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (value) => print(value),
        onItemUnSelect: (_) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate =
          (Widget widget) => widget is SwitchItem && widget.label == "two";

      expectLater(
        () => tester.tap(find.byWidgetPredicate(predicate)),
        prints("2\n"),
      );
    },
  );

  testWidgets(
    'Tap on reset option executes onReset callback',
    (WidgetTester tester) async {
      final widget = MultipleItemPicker<int?>(
        list: [],
        resetOption: MapEntry("reset", null),
        onResetSelection: () => print('reset'),
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate =
          (Widget widget) => widget is SwitchItem && widget.label == "reset";

      expectLater(
        () => tester.tap(find.byWidgetPredicate(predicate)),
        prints("reset\n"),
      );
    },
  );

  testWidgets(
    'Tap on item add it to selection',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        defaultValues: [1],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate oneIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "one" &&
          widget.isSelected == true;

      WidgetPredicate twoIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.isSelected == true;

      // Assert one (default) is selected and two is not
      expect(find.byWidgetPredicate(oneIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(twoIsSelected), findsNothing);

      //Tap on item two
      WidgetPredicate predicate2 =
          (Widget widget) => widget is SwitchItem && widget.label == "two";
      await tester.tap(find.byWidgetPredicate(predicate2));
      await tester.pump();

      //Assert two is selected and one is still selected too
      expect(find.byWidgetPredicate(oneIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(twoIsSelected), findsOneWidget);
    },
  );

  testWidgets(
    'Un select item executes un selection callback',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (value) => print(value),
        defaultValues: [2],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate =
          (Widget widget) => widget is SwitchItem && widget.label == "two";

      expectLater(
        () => tester.tap(find.byWidgetPredicate(predicate)),
        prints("2\n"),
      );
    },
  );

  testWidgets(
    'Tap on selected item remote it from selection',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        defaultValues: [1, 2],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate oneIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "one" &&
          widget.isSelected == true;

      WidgetPredicate twoIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.isSelected == true;

      // Assert one and two (default) are selected
      expect(find.byWidgetPredicate(oneIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(twoIsSelected), findsOneWidget);

      //Tap on item two
      WidgetPredicate predicate2 =
          (Widget widget) => widget is SwitchItem && widget.label == "two";
      await tester.tap(find.byWidgetPredicate(predicate2));
      await tester.pump();

      //Assert two is anymore selected and one is still
      expect(find.byWidgetPredicate(oneIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(twoIsSelected), findsNothing);
    },
  );

  testWidgets(
    'Tap on reset reset selection',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int?>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        onResetSelection: () {},
        resetOption: MapEntry("reset", null),
        defaultValues: [1, 2],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate oneIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "one" &&
          widget.isSelected == true;

      WidgetPredicate twoIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.isSelected == true;

      WidgetPredicate resetIsSelected = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "reset" &&
          widget.isSelected == true;

      // Assert one and two (default) are selected while reset is not
      expect(find.byWidgetPredicate(oneIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(twoIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(resetIsSelected), findsNothing);

      //Tap on reset
      WidgetPredicate predicateReset =
          (Widget widget) => widget is SwitchItem && widget.label == "reset";
      await tester.tap(find.byWidgetPredicate(predicateReset));
      await tester.pump();

      //Assert one nor two is anymore selected and reset is selected instead
      expect(find.byWidgetPredicate(resetIsSelected), findsOneWidget);
      expect(find.byWidgetPredicate(oneIsSelected), findsNothing);
      expect(find.byWidgetPredicate(twoIsSelected), findsNothing);
    },
  );

  testWidgets(
    'Style is applied',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      List<TextStyle> _styles = [
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.red),
        TextStyle(color: Colors.green),
      ];

      TextStyle _resetStyle = TextStyle(color: Colors.orange);

      final widget = MultipleItemPicker<int?>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        onResetSelection: () {},
        resetOption: MapEntry("reset", null),
        resetOptionStyle: _resetStyle,
        itemStyles: _styles,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate1 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "one" &&
          widget.labelStyle == _styles[0];

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.labelStyle == _styles[1];

      WidgetPredicate predicate3 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "three" &&
          widget.labelStyle == _styles[2];

      WidgetPredicate predicateReset = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "reset" &&
          widget.labelStyle == _resetStyle;

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
      expect(find.byWidgetPredicate(predicateReset), findsOneWidget);
    },
  );

  testWidgets(
    'Default style is applied if no style is provided',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = MultipleItemPicker<int?>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        onResetSelection: () {},
        resetOption: MapEntry("reset", null),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate1 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "one" &&
          widget.labelStyle == TextStyles.switchItemLabel();

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.labelStyle == TextStyles.switchItemLabel();

      WidgetPredicate predicate3 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "three" &&
          widget.labelStyle == TextStyles.switchItemLabel();

      WidgetPredicate predicateReset = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "reset" &&
          widget.labelStyle == TextStyles.switchItemLabel();

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
      expect(find.byWidgetPredicate(predicateReset), findsOneWidget);
    },
  );

  testWidgets(
    'Selected style is applied on selected items',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      List<TextStyle> _styles = [
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.red),
        TextStyle(color: Colors.green),
      ];

      final widget = MultipleItemPicker<int>(
        list: _entries,
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        itemStyles: _styles,
        defaultValues: [1, 3],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate1 = (Widget widget) =>
          widget is Text &&
          widget.data == "one" &&
          widget.style == TextStyles.selectedSwitchItemLabel(_styles[0].color);

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.labelStyle == _styles[1];

      WidgetPredicate predicate3 = (Widget widget) =>
          widget is Text &&
          widget.data == "three" &&
          widget.style == TextStyles.selectedSwitchItemLabel(_styles[2].color);

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
    },
  );

  testWidgets(
    'Selected style is applied on reset selected',
    (WidgetTester tester) async {
      TextStyle _resetStyle = TextStyle(color: Colors.orange);

      final widget = MultipleItemPicker<int?>(
        list: [],
        onItemSelect: (_) {},
        onItemUnSelect: (_) {},
        onResetSelection: () {},
        resetOption: MapEntry("reset", null),
        resetOptionStyle: _resetStyle,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicateReset = (Widget widget) =>
          widget is Text &&
          widget.data == "reset" &&
          widget.style == TextStyles.selectedSwitchItemLabel(_resetStyle.color);

      expect(find.byWidgetPredicate(predicateReset), findsOneWidget);
    },
  );
}
