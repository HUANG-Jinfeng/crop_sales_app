import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/screen/order/order_page.dart';
import 'package:crop_sales_app/screen/order_detail/order_detail_page.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

import 'cart_list_class.dart';

class CartListBottom extends StatelessWidget {
  CartListBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomHeight =
        MediaQuery.of(context).padding.bottom + (Platform.isAndroid ? 2 : 0); //
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(bottomHeight),
        decoration: const BoxDecoration(
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
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(),
              child: OutlineButton(
                shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () => {
                  MyNavigator.pop(),
                },
                splashColor: AppColors.supplierColor2,
                highlightElevation: 5.0,
                child: const Center(
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
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(),
              child: FlatButton(
                splashColor: AppColors.splashColor,
                shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                //onPressed: () => MyNavigator.push(const PayPage(orderId: "id")),
                onPressed: () => {
                  makeAOrderIDs(),
                  MyNavigator.push(const OrderPage())
                },
                color: AppColors.primaryColor,
                child: const Center(
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

  List<CartCropDetial> carts = [];
  Future makeAOrderIDs() async {
    ///
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    //print(uidCartID);

    ///
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(uidCartID)
        .collection('crop_ids')
        .get();
    final List<CartCropDetial> carts =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData =
          document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String desc = cartListData['description'];
      final String url = cartListData['url'];
      final int maxcount = cartListData['maxBuyCount'];
      final int quantity = cartListData['quantity'];
      final int price = cartListData['price'];
      return CartCropDetial(id, name, desc, url, maxcount, quantity, price);
    }).toList();

    ///
    int now = DateTime.now().millisecondsSinceEpoch;
    int totalPrice = 0;
    int totalQuantity = 0;
    for (var i = 0; i < carts.length; i++) {
      print(carts[i].crop_id);
      final docOrderIDs = FirebaseFirestore.instance
          .collection('orders')
          .doc(uidCartID)
          .collection('orderIDs')
          .doc(now.toString())
          .collection('OrderCropList')
          .doc(carts[i].crop_id);
      await docOrderIDs.set(
        {
          'id': carts[i].crop_id,
          'name': carts[i].crop_name,
          'description': carts[i].crop_desc,
          'url': carts[i].crop_imageURL,
          'price': carts[i].single_price,
          'quantity': carts[i].single_quantity,
        },
      );
      totalPrice = totalPrice + carts[i].single_price * carts[i].single_quantity;
      totalQuantity = totalQuantity + carts[i].single_quantity;
    }

    ///
    DateTime date = DateTime.now();
    final docOrder =
        FirebaseFirestore.instance
            .collection('orders')
            .doc(uidCartID)
            .collection('orderIDs')
            .doc(now.toString());
    //print(now);
    await docOrder.set(
      {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'order_id': 'LT$now',
        'order_state': 'Paying',
        'isPay': false,
        'isDate': date,
        'order_total_quantity': totalQuantity,
        'order_total_price': totalPrice,
      },
    );
  }
}
