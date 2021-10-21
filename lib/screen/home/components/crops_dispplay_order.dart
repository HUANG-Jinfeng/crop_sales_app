import 'package:crop_sales_app/components/left_title.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';

class CropsSelectPage extends StatefulWidget {
  @override
  _CropsSelectPageState createState() => _CropsSelectPageState();
}

class _CropsSelectPageState extends State<CropsSelectPage> {
  var _value;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)
              ),
            ),
            child: Row(children: <Widget>[
              Expanded(child: _itemCrops('Crops',null)),
              SizedBox(width: 20),
              Expanded(child: _itemCrops('Order',null)),
              SizedBox(width: 15),
            ]),
          ),
        ],
      ),
    );
  }

  _itemCrops(title,style) {
    return DropdownButton(
        value: _value,
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: AppColors.primaryColor,
        hint: LeftTitle(
          tipColor: AppColors.primaryColor,
          title: title,
        ),
        isExpanded: true,
        underline: Container(height: 1, color: AppColors.primaryColor),
        style: style,
        items: [
          DropdownMenuItem(
              child: Row(children: <Widget>[
                Text(
                  'Tomato',
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 10),
                //Icon(Icons.ac_unit)
              ]),
              value: 1),
          DropdownMenuItem(
              child: Row(children: <Widget>[
                Text('Potato'),
                SizedBox(width: 10),
                //Icon(Icons.content_paste)
              ]),
              value: 2),
          DropdownMenuItem(
              child: Row(children: <Widget>[
                Text('Onion', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                //Icon(Icons.send)
              ]),
              value: 3)
        ],
        onChanged: (value) => setState(() => _value = value));
  }
}
