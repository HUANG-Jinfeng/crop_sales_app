import 'package:flutter/material.dart';

class MyCheckButton extends StatefulWidget {
  const MyCheckButton({Key? key}) : super(key: key);

  @override
  TestMyAppState createState() => TestMyAppState();
}

class TestMyAppState extends State<MyCheckButton> {
  late bool _isButton1Disabled;
  int _counter = 1;

  late GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    _isButton1Disabled = false;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isButton1Disabled = true;
      } else {
        _isButton1Disabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _key= GlobalKey<ScaffoldState>();
    return MaterialApp(
        home: Scaffold(
            key: _key,
            appBar: AppBar(title: const Text("test app")),
            body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: buildButtons(),
                ))));
  }

  List<Widget> buildButtons() {
    List<Widget> list = [
      _buildButton1(_counter),
      _buildSpaceView(20.0), //在两个按钮间添加一点间隔
      _buildButton2()
    ];

    return list;
  }

  Widget _buildSpaceView(double _height) {
    return Container(height: _height);
  }

  _buildButton1(int counter) {
    return RaisedButton(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Text(
          'count: ' + counter.toString(),
          style: const TextStyle(
            fontSize: 18.0, //textsize
            color: Colors.white, // textcolor
          ),
        ),
        color: Theme.of(context).accentColor,
        elevation: 4.0,
        //shadow
        splashColor: Colors.blueGrey,
        onPressed: _getBtn1ClickListener());
  }

  _buildButton2() {
    return RaisedButton(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: const Text(
          'click me',
          style: TextStyle(
            fontSize: 18.0, //textsize
            color: Colors.white, // textcolor
          ),
        ),
        color: Theme.of(context).accentColor,
        elevation: 4.0,
        //shadow
        splashColor: Colors.blueGrey,
        onPressed: _getBtn2ClickListener());
  }

  _getBtn2ClickListener() {
    return () {
      _incrementCounter();
    };
  }

  _getBtn1ClickListener() {
    if (_isButton1Disabled) {
      return null;
    } else {
      return () {
        _key.currentState!.showSnackBar(const SnackBar(
          content: Text('Hello!'),
        ));
      };
    }
  }
}
