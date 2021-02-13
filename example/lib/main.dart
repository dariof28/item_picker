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
  int selectedValue = 1;
  List<TextStyle> styles;
  Widget marker;
  Widget separator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          child: ItemPicker<int>(
            list: [
              MapEntry("One", 1),
              MapEntry("Two", 2),
              MapEntry("Three", 3),
              MapEntry("Four", 4),
              MapEntry("Five", 5),
            ],
            defaultValue: selectedValue,
            itemStyles: styles,
            selectedMarker: marker,
            separator: separator,
            onSelectionChange: (value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
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
        FlatButton(
          onPressed: () {
            setState(() {
              styles = [
                TextStyle(color: Colors.green),
                TextStyle(color: Colors.blue),
                TextStyle(color: Colors.red),
                TextStyle(color: Colors.yellow),
                TextStyle(color: Colors.black),
              ];
            });
          },
          child: Text('Custom style'),
        ),
        Expanded(
          child: FlatButton(
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
        FlatButton(
          onPressed: () {
            setState(() {
              marker = Icon(Icons.star, color: Colors.deepOrange);
            });
          },
          child: Text('Custom marker'),
        ),
        Expanded(
          child: FlatButton(
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
        FlatButton(
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
          child: FlatButton(
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
