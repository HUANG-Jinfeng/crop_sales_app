import 'dart:io';

import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

class CartListBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQuery.of(context).padding.bottom + (Platform.isAndroid ? 2 : 0); //
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(bottomHeight),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8EAEB),
              width: 1.0,
            ),
          ),
        ),
        height: 55.0 + bottomHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(),
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () => {
                  MyNavigator.pop(),
                },
                splashColor: AppColors.supplierColor2,
                highlightElevation: 5.0,
                child: Center(
                  child: Text(
                    'Cancel order',
                    style: TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 150,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(),
              child: FlatButton(
                splashColor: AppColors.splashColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () => MyNavigator.push(PayPage(orderId: "id")),
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    'Check order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
