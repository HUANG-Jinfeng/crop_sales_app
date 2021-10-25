import 'count_text.dart';
import 'package:flutter/material.dart';

typedef onPressed_changestate();

class ButtonWidget extends StatefulWidget {
  //类变量,作为调用类时的参数
  onPressed_changestate onPressed;
  ButtonWidget({required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _ButtonWidgetState(onPressed);
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  onPressed_changestate new_onPressed;
  _ButtonWidgetState(this.new_onPressed);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('count++',style: TextStyle(fontSize: 20),),
        onPressed: new_onPressed,
        //new_onPressed是main.dart调用该控件时传递过来的方法
        //也就是 onPressed: () {
        //   _count++;
        //   textKey.currentState.onPressed(  _count);
        // },
      ),
    );
  }
}