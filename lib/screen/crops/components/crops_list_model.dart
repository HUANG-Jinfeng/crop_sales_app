import 'dart:io';

import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CropListModel extends ChangeNotifier {
  List<Crop>? crops;

  void fetchCropList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('crops').get();

    final List<Crop> crops = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String crop_category_id = data['crop_category_id'];
      final String crop_id = data['crop_id'];
      final String crop_name = data['crop_name'];
      final Timestamp date = data['date'];
      final String description = data['description'];
      final String image = data['image'];
      final String memo = data['memo'];
      final String price = data['price'];
      final String volume = data['volume'];
      return Crop(crop_category_id, crop_id, crop_name, date, description,
          image, memo, price, volume);
    }).toList();

    this.crops = crops;
    notifyListeners();
  }

  Future<int> doesNameAlreadyExist(String id) async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uid_cartID = data?['cart_id'];
    int check = 0;

    /*FirebaseFirestore.instance
        .collection('cart')
        .doc(uid_cartID)
        .collection('crop_ids')
        .doc(id)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
        } else {
          print('Document not exists on the database');
        }
      },
    );*/

    final result =
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(uid_cartID)
        .collection('crop_ids')
        .doc(id)
        .get();
    if (result.exists) {
      check = 1;
    }else{
      check = -1;
    }
    //print(check);
    return check;
  }

  Future addCropToCart(
      id, name, description, url, price, quantity, total) async {
    final uid_cartID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uid_cartID.data();
    final String uid_cropID = data?['cart_id'];

    //quantity = quantity+2;
    final doc = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid_cropID)
        .collection('crop_ids')
        .doc(id);
    await doc.set({
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'price': price,
      'quantity': quantity,
      'maxBuyCount': total,
      'isCollect': true,
    });

    MyToast.show('Added to cart!');
  }

  String? PRICE;
  String? QUANTITY;

  Future addTotalPrice(id, price, _counter) async {
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
}
