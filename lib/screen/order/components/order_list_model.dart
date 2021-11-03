import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/order/components/order_list_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderListModel with ChangeNotifier {
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  List<OrderDetail>? orderCarts;
  Orders? orders;
  Future fetchOrderCropList() async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];

    final orderIDs = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .get();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .doc(orderIDs.docs.last.id)
        .collection('OrderCropList')
        .get();
    final List<OrderDetail> crops =
    snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData =
      document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String desc = cartListData['description'];
      final String url = cartListData['url'];
      final int price = cartListData['price'];
      final int quantity = cartListData['quantity'];
      return OrderDetail(id, name, desc, url, price, quantity);
    }).toList();
    orderCarts = crops;

    final order = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .doc(orderIDs.docs.last.id)
        .get();
    var ordersData = order as DocumentSnapshot;
    //Map<String, dynamic> ordersData = order as Map<String, dynamic>;
    final String uid = ordersData['uid'];
    final String order_id = ordersData['order_id'];
    final String order_state = ordersData['order_state'];
    final bool isPay = ordersData['isPay'];
    final Timestamp isDate = ordersData['isDate'];
    final int order_total_quantity = ordersData['order_total_quantity'];
    final int order_total_price = ordersData['order_total_price'];
    orders = Orders(
        uid,
        order_id,
        order_state,
        isPay,
        isDate,
        order_total_quantity,
        order_total_price);
    //orders = Orders;
    print('orderID: ${order_id}');
    //return crops;
    notifyListeners();
  }

  Future fetchOrder() async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];

    final orderIDs = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .get();
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .doc(orderIDs.docs.last.id)
        .get();
    final orderDetial = snapshot.data();
    var uid = orderDetial?['uid'];
    var order_id = orderDetial?['order_id'];
    var order_state = orderDetial?['order_state'];
    var isPay = orderDetial?['isPay'];
    var order_total_quantity = orderDetial?['order_total_quantity'];
    var order_total_price = orderDetial?['order_total_price'];
    print('orderID: $order_id');
    notifyListeners();
  }
}
