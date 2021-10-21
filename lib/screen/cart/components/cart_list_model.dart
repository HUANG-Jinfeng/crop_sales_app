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

  void totalPrice() {}

  void totalQuantity() {}

  void fetchCartCropList() async {
    final uid_cartID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uid_cartID.data();
    final String uid_cropID = data?['cart_id'];
    print(uid_cropID);

    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('cart').doc(uid_cropID).collection('crop_ids').get();

    final List<CartCropDetial> carts = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData = document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String url = cartListData['url'];
      final String count = cartListData['minBuyCount'];
      final int quantity = cartListData['quantity'];
      final String price = cartListData['price'];
      return CartCropDetial(id,name,url,count,quantity,price);
    }).toList();

    print(carts.isEmpty);
    print(CartCropDetial);

    this.carts = carts;
    notifyListeners();
  }
}
