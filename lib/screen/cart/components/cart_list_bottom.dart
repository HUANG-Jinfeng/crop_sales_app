import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

//import 'package:crop_sales_app/screen/confirm_order/confirm_order.dart';
import 'package:crop_sales_app/screen/cart/store/shopping_cart_provider.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

class CartListBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQuery.of(context).padding.bottom; //
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: bottomHeight),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8EAEB),
              width: 1.0,
            ),
          ),
        ),
        height: 80.0 + bottomHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(),
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () => {},
                splashColor: AppColors.splashColor,
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
              padding: EdgeInsets.all(10),
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
                    'Pay immediately',
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