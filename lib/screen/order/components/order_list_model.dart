import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/order/components/order_list_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderListModel extends ChangeNotifier {
  List<OrderDetail>? carts;

  //String? uid;
  //String? cart_id;
  //String? crop_ids;
  //String? date;
  //String? total_price;
  //String? total_quantity;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  String? uid;
  String? order_id;
  String? order_state;
  bool? isPay;
  String? isDate;
  int? order_total_quantity;
  int? order_total_price;
  Future makeAOrderIDs() async {
    final uID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    print(uidCartID);

    final docOrder =
    FirebaseFirestore.instance.collection('orders').doc('$uidCartID');
    DateTime now = DateTime.now();
    await docOrder.set(
        {
          'uid': uID,
          'order_id': '00001',
          'order_state': 'Paying',
          'isPay': false,
          'isDate': now,
          'order_total_quantity': 10, //
          'order_total_price': 20000, //
        }
    );
  }

  String? PRICE;
  String? QUANTITY;
  Future cartTotalQuantityAndPrice(price, _counter) async {
    final uid_cartID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uid_cartID.data();
    final String uid_cropID = data?['cart_id'];

    final totalPrice = await FirebaseFirestore.instance
        .collection('cart')
        .doc(uid_cropID)
        .get();
    final cartdata = totalPrice.data();
    PRICE = cartdata?['total_price']; //print(PRICE);
    QUANTITY = cartdata?['total_quantity']; //print(QUANTITY);

    var a = PRICE!;
    var b = QUANTITY!;
    if (a == 0) {
      a = price;
      b = _counter;
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uid_cropID)
          .update({
        'total_price': a,
        'total_quantity': b,
      });
    } else {
      a = a + price;
      b = b + _counter;
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uid_cropID)
          .update({
        'total_price': a,
        'total_quantity': b,
      });
    }
  }

  Future eachCropTotalQuantityAndPrice(cropID, count, totalPrice) async {
    final uID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uID.data();
    final String uid_cartID = data?['cart_id'];
    print(cropID);

    await FirebaseFirestore.instance
        .collection('cart')
        .doc(uid_cartID)
        .collection('crop_ids')
        .doc(cropID)
        .update({
      'quantity': count,
      'totalPrice': totalPrice,
    });
  }

  /*void fetchCartCropList() async {
    final uID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    print(uidCartID);

    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('cart').doc(uidCartID).collection('crop_ids').get();

    final List<CartCropDetial> carts = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData = document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String desc = cartListData['description'];
      final String url = cartListData['url'];
      final int maxcount = cartListData['maxBuyCount'];
      final int quantity = cartListData['quantity'];
      final int price = cartListData['price'];
      return CartCropDetial(id,name,desc,url,maxcount,quantity,price);
    }).toList();

    this.carts = carts;
    notifyListeners();
  }*/
}
