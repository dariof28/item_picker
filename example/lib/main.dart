import 'package:flutter/material.dart';
import 'package:item_picker/item_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ItemPicker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter ItemPicker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TextStyle> styles;
  Widget marker;
  Widget separator;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Single item",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: "Multiple item",
          ),
        ],
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          child: pageIndex == 0
              ? SingleItem(
                  separator: separator,
                  marker: marker,
                  styles: styles,
                )
              : MultipleItem(
                  separator: separator,
                  marker: marker,
                  styles: styles,
                ),
        ),
        _buildSettings(),
      ],
    );
  }

  Widget _buildSettings() {
    return Column(
      children: [
        _styleSetting(),
        _markerSetting(),
        _separatorSetting(),
      ],
    );
  }

  Widget _styleSetting() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              styles = [
                TextStyle(color: Colors.green),
                TextStyle(color: Colors.blue),
                TextStyle(color: Colors.red),
                TextStyle(color: Colors.yellow),
                TextStyle(color: Colors.deepOrange),
              ];
            });
          },
          child: Text('Custom style'),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                styles = null;
              });
            },
            child: Text('Default style'),
          ),
        ),
      ],
    );
  }

  Widget _markerSetting() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              marker = Icon(Icons.star, color: Colors.deepOrange);
            });
          },
          child: Text('Custom marker'),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                marker = null;
              });
            },
            child: Text('Default marker'),
          ),
        ),
      ],
    );
  }

  Widget _separatorSetting() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              separator = Column(
                children: [
                  Container(height: 2.0, color: Colors.black38),
                  Container(height: 1.0, color: Colors.white),
                  Container(height: 2.0, color: Colors.black38),
                ],
              );
            });
          },
          child: Text('Custom separator'),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                separator = null;
              });
            },
            child: Text('Default separator'),
          ),
        ),
      ],
    );
  }
}

class SingleItem extends StatefulWidget {
  final List<TextStyle> styles;
  final Widget marker;
  final Widget separator;

  SingleItem({this.styles, this.marker, this.separator});

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemPicker<int>(
          list: [
            MapEntry("One", 1),
            MapEntry("Two", 2),
            MapEntry("Three", 3),
            MapEntry("Four", 4),
            MapEntry("Five", 5),
          ],
          defaultValue: selectedValue,
          itemStyles: widget.styles,
          selectedMarker: widget.marker,
          separator: widget.separator,
          onSelectionChange: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              selectedValue,
              (index) => Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }
}

class MultipleItem extends StatefulWidget {
  final List<TextStyle> styles;
  final Widget marker;
  final Widget separator;

  MultipleItem({this.styles, this.marker, this.separator});

  @override
  _MultipleItemState createState() => _MultipleItemState();
}

class _MultipleItemState extends State<MultipleItem> {
  List<String> _selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultipleItemPicker<String>(
          list: [
            MapEntry("Dog", "dog"),
            MapEntry("Cat", "cat"),
            MapEntry("Bird", "bird"),
            MapEntry("Hamster", "hamster"),
            MapEntry("Goldfish", "goldfish"),
          ],
          itemStyles: widget.styles,
          selectedMarker: widget.marker,
          separator: widget.separator,
          onItemSelect: (value) {
            setState(() {
              _selectedValues.add(value);
            });
          },
          onItemUnSelect: (value) {
            setState(() {
              _selectedValues.remove(value);
            });
          },
          resetOption: MapEntry("Reset selection", null),
          onResetSelection: () {
            setState(() {
              _selectedValues.clear();
            });
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Selection: " + _selectedValues.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
