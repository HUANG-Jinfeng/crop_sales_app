import 'dart:io';
import 'package:crop_sales_app/screen/cart/cart_page_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/screen/cart/store/shopping_cart_global_provider.dart';

class AppBarShopCartIconButton extends StatelessWidget {
  const AppBarShopCartIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.fromLTRB(6, 6, 8, 6),
      icon: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.asset('assets/images/home/gouwuche.png',
                  width: 22, height: 22),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Selector<ShopingCartGlobalProvider, String>(
                  builder: (_, count, __) {
                    return Visibility(
                      //visible: count != "0",
                      visible: count == "0",
                      child: _badgeWidget(count),
                    );
                  },
                  selector: (context, model) => model.goodsCountString),
            )
          ],
        ),
      ),
      //onPressed: () => MyNavigator.push(CartListPage()),
      //onPressed: () => MyNavigator.push(CartPage()),
      onPressed: () => Navigator.push(context,
                 MaterialPageRoute(builder: (context) => CartPageHome())),
      //onPressed: () => MyNavigator.push(CartPageHome()),
    );
  }

  Container _badgeWidget(String count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1.5, color: Colors.white),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 14),
        child: Container(
          height: 14,
          padding: EdgeInsets.only(
              left: 4, right: 4, bottom: Platform.isIOS ? 1 : 0),
          decoration: BoxDecoration(
            color: Color(0xFFB80821),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              count,
              style: TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
        ),
      ),
    );
  }
}
