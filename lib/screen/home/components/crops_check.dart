import 'package:crop_sales_app/components/left_title.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropsCheckBox extends StatefulWidget {
  @override
  _CropsCheckBoxState createState() => _CropsCheckBoxState();
}

class _CropsCheckBoxState extends State<CropsCheckBox> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          ExpansionTile(
            title: LeftTitle(
              tipColor: AppColors.primaryColor,
              title: 'Crops',
            ),
            //leading: Icon(Icons.list),
            children: <Widget>[
              ListTile(
                title: Text('Tomato'),
              ),
              ListTile(
                title: Text('Lettuce'),
              ),
              ListTile(
                title: Text('Onion'),
              ),
              ListTile(
                title: Text('Potato'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
