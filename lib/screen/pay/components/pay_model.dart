import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PayModel extends ChangeNotifier {
  List<Crop>? crops;

  void readOrder() async {
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

  Future makeOrder(id,name,url,price,quantity,total) async {
    final uid_cartID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uid_cartID.data();
    final String uid_cropID = data?['cart_id'];

    final doc = FirebaseFirestore.instance.collection('cart').doc(uid_cropID).collection('crop_ids').doc(id);
    await doc.set(
        {
          'id': id,
          'name': name,
          'url': url,
          'price': price,
          'quantity': quantity,
          'minBuyCount': total,
        }
    );
    MyToast.show('Added to cart!');
  }

  bool isLoading = false;
  String? PRICE;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future readTotalPrice() async {
    final uid_cartID =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = uid_cartID.data();
    final String uid_cropID = data?['cart_id'];

    final totalPrice =
    await FirebaseFirestore.instance.collection('cart').doc(uid_cropID).get();
    final cartdata = totalPrice.data();
    this.PRICE = cartdata?['total_price']; //print(PRICE);

    notifyListeners();
  }
}
