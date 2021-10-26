import 'package:flutter/material.dart';

//void main() => runApp(new MyApp());

class MyCheckButton extends StatefulWidget {
  @override
  TestMyAppState createState() => new TestMyAppState();
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
    _key= new GlobalKey<ScaffoldState>();
    return new MaterialApp(
        home: new Scaffold(
            key: _key,
            appBar: new AppBar(title: new Text("test app")),
            body: new Container(
                alignment: Alignment.center,
                child: new Container(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildButtons(),
                    )))));
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
    return new Container(height: _height);
  }

  RaisedButton _buildButton1(int counter) {
    return new RaisedButton(
        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: new Text(
          'count: ' + counter.toString(),
          style: new TextStyle(
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

  RaisedButton _buildButton2() {
    return new RaisedButton(
        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: new Text(
          'click me',
          style: new TextStyle(
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
        _key.currentState!.showSnackBar(new SnackBar(
          content: new Text('Hello!'),
        ));
      };
    }
  }
}
