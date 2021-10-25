import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'cart_list_class.dart';

class CartListModel extends ChangeNotifier {
  List<CartCropDetial>? carts;

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

    var a = int.parse(PRICE!);
    num b = int.parse(QUANTITY!);
    if (a == 0) {
      a = int.parse(price);
      b = _counter;
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uid_cropID)
          .update({
        'total_price': a.toString(),
        'total_quantity': b.toString(),
      });
    } else {
      a = a + int.parse(price);
      b = b + _counter;
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uid_cropID)
          .update({
        'total_price': a.toString(),
        'total_quantity': b.toString(),
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
      'totalPrice': totalPrice.toString(),
    });
  }

  void fetchCartCropList() async {
    final uID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uID.data();
    final String uid_cartID = data?['cart_id'];
    print(uid_cartID);

    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('cart').doc(uid_cartID).collection('crop_ids').get();

    final List<CartCropDetial> carts = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData = document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String desc = cartListData['description'];
      final String url = cartListData['url'];
      final String maxcount = cartListData['maxBuyCount'];
      final int quantity = cartListData['quantity'];
      final String price = cartListData['price'];
      return CartCropDetial(id,name,desc,url,maxcount,quantity,price);
    }).toList();
    
    this.carts = carts;
    notifyListeners();
  }
}
