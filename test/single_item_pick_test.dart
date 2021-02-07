import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_picker/item_picker.dart';
import 'package:item_picker/src/styles.dart';
import 'package:item_picker/src/switch_item.dart';

main() {
  testWidgets('Item picker should have as many styles as many entries provided',
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
      () => ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
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
    'Default value should be selected if provided',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
        defaultValue: 2,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is SwitchItem &&
          widget.label == "two" &&
          widget.isSelected == true;

      WidgetPredicate predicateOther = (Widget widget) =>
          widget is SwitchItem &&
          widget.label != "two" &&
          widget.isSelected == false;

      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicateOther), findsNWidgets(2));
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
        defaultValue: 2,
        selectedMarker: marker,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate2 = (Widget widget) =>
          widget is Visibility &&
          widget.visible == true &&
          widget.child == marker;

      WidgetPredicate predicateOther = (Widget widget) =>
          widget is Visibility &&
          widget.visible == false &&
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
        defaultValue: 2,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      WidgetPredicate predicate2 =
          (Widget widget) => widget is Visibility && widget.visible == true;

      WidgetPredicate predicateOther =
          (Widget widget) => widget is Visibility && widget.visible == false;

      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
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
    'Tap on item executes callback',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (value) => print(value),
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
    'Tap on item changes selection',
    (WidgetTester tester) async {
      List<MapEntry<String, int>> _entries = [
        MapEntry("one", 1),
        MapEntry("two", 2),
        MapEntry("three", 3),
      ];

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
        defaultValue: 1,
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

      //Assert two is selected and one is not anymore
      expect(find.byWidgetPredicate(oneIsSelected), findsNothing);
      expect(find.byWidgetPredicate(twoIsSelected), findsOneWidget);
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
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

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
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

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
    },
  );

  testWidgets(
    'Selected style is applied on selected item',
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

      final widget = ItemPicker<int>(
        list: _entries,
        onSelectionChange: (_) {},
        itemStyles: _styles,
        defaultValue: 2,
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
      widget is Text &&
          widget.data == "two" &&
          widget.style == TextStyles.selectedSwitchItemLabel(_styles[1].color);

      WidgetPredicate predicate3 = (Widget widget) =>
      widget is SwitchItem &&
          widget.label == "three" &&
          widget.labelStyle == _styles[2];

      expect(find.byWidgetPredicate(predicate1), findsOneWidget);
      expect(find.byWidgetPredicate(predicate2), findsOneWidget);
      expect(find.byWidgetPredicate(predicate3), findsOneWidget);
    },
  );
}
