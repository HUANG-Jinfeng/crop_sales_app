import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
//import 'package:crop_sales_app/screen/confirm_order/confirm_order.dart';
import 'package:crop_sales_app/screen/cart/store/shopping_cart_provider.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQuery.of(context).padding.bottom; // 获取安全距离
    // 取出方法
    final selectAllGood =
        Provider.of<ShopingCartProvider>(context, listen: false).selectAllCrop;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // color: Colors.white,
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
        height: 60.0 + bottomHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Selector<ShopingCartProvider, bool>(
                    selector: (_, shopingCartProvider) =>
                        shopingCartProvider.isSelectAllCrop,
                    builder: (_, isSelectAllGood, __) {
                      return GestureDetector(
                        onTap: () => selectAllGood(),
                        child: isSelectAllGood
                            ? Image.asset(
                                'assets/images/shopping_cart/check.png',
                                width: 24.0,
                                height: 24.0,
                              )
                            : Image.asset(
                                'assets/images/shopping_cart/bottom_check.png',
                                width: 24.0,
                                height: 24.0,
                              ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: selectAllGood,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'All check',
                            style: TextStyle(
                              color: Color(0xFF18191A),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Selector<ShopingCartProvider, int>(
                            selector: (_, shopingCartProvider) =>
                                shopingCartProvider.cropTotalNum,
                            builder: (_, goodTotalNum, __) {
                              return Text(
                                //'数量  $goodTotalNum',
                                '$goodTotalNum',
                                style: TextStyle(
                                  color: Color(0xFF979899),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Selector<ShopingCartProvider, Tuple3<bool, int, Function>>(
              selector: (_, shoppingCartProvider) => Tuple3(
                  shoppingCartProvider.isEditMode,
                  shoppingCartProvider.cropTotalNum,
                  shoppingCartProvider.deteleCrop),
              builder: (_, tuple, __) {
                return tuple.item1
                    ? Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: OutlineButton(
                          child: Text(
                            'Delete (' + tuple.item2.toString() + ')',
                            style: TextStyle(
                              color: Color(0xFF17191A),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () => tuple.item3(),
                        ),
                      )
                    : Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(right: 7.5),
                              child: Selector<ShopingCartProvider, int>(
                                selector: (_, shopingCartProvider) =>
                                    shopingCartProvider.cropTotalPrice,
                                builder: (_, goodTotalPrice, __) {
                                  return Text(
                                    'PHP $goodTotalPrice',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.priceColor,
                                    ),
                                  );
                                },
                              )),
                          GestureDetector(
                            //onTap: () => MyNavigator.push(ConfirmOrderPage()),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  //背景径向渐变
                                  colors: [
                                    AppColors.buttonLine1,
                                    AppColors.buttonLine2
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                              width: 120.0,
                              height: 60.0,
                              child: Center(
                                child: Text(
                                  'Place order',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
