import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumChangeWidget extends StatefulWidget {
  final double height;
  int num;
  final ValueChanged<int> onValueChanged;

  NumChangeWidget(
      {required Key key,
      this.height = 36.0,
      this.num = 0,
      required this.onValueChanged})
      : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    return _NumChangeWidgetState();
  }
}

class _NumChangeWidgetState extends State<NumChangeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: _minusNum,
            child: Container(
              width: 32.0,
              alignment: Alignment.center,
              child: Image.asset('assets/images/shopping_cart/down.png'), // 设计图
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.grey,
          ),
          Container(
            width: 62.0,
            alignment: Alignment.center,
            child: Text(
              widget.num.toString(),
              maxLines: 1,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: _addNum,
            child: Container(
              width: 32.0,
              alignment: Alignment.center,
              child: Image.asset('assets/images/shopping_cart/up.png'), // 设计图
            ),
          ),
        ],
      ),
    );
  }

  void _minusNum() {
    if (widget.num == 0) {
      return;
    }

    setState(() {
      widget.num -= 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }

  void _addNum() {
    setState(() {
      widget.num += 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }
}
