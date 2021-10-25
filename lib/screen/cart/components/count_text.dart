import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  //! 接收传过来的key
  TextWidget(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextWidgetState();
  }
}

class TextWidgetState extends State<TextWidget> {
  String _text="1";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_text,style: Theme.of(context).textTheme.bodyText1, ),
    );
  }
  //在TextWidget的onPressed中单独调用TextWidget的setState,刷新本控件.
  void onPressed(int count) {
    setState(() {
      _text = count.toString();
    });
  }
}