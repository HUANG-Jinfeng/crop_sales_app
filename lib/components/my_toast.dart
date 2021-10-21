import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MyToast {
  static show(String msg, {int duration = 2000}) {
    showToast(
        msg,
        textStyle: TextStyle(color: Colors.white, fontSize: 18.0),
        duration: Duration(milliseconds: duration),
        textPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        radius: 6,
    );
  }
}
