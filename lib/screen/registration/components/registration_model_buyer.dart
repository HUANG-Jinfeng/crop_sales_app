import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/my_loading.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_class.dart';
import 'package:crop_sales_app/screen/login/buyer_login_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyerRegisterModel extends ChangeNotifier {
  final TelController = TextEditingController();
  final addressController = TextEditingController();
  final categoryIDController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  //final uidController = TextEditingController();
  final passwordController = TextEditingController();

  String? Tel;
  String? address;
  String? category_id = '1';
  String? city;
  String? email;
  String? name;

  //String? uid;
  String? password;

  // 注册时创建专属购物车ID
  //List<Cart>? cart;
  String? uid;
  String? cart_id;

  //String? crop_ids;
  String? date;
  String? total_price = '0';
  String? total_quantity = '0';

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setTel(String Tel) {
    this.Tel = Tel;
    notifyListeners();
  }

  void setAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  void setCategory_id(String category_id) {
    category_id = '1';
    this.category_id = category_id;
    notifyListeners();
  }

  void setCity(String city) {
    this.city = city;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  /*void setUid(String uid) {
    this.uid = uid;
    notifyListeners();
  }*/

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    this.Tel = TelController.text;
    this.address = addressController.text;
    this.category_id = categoryIDController.text;
    this.city = cityController.text;
    this.email = emailController.text;
    this.name = nameController.text;
    //this.uid = uidController.text;
    this.password = passwordController.text;

    if (email != null && password != null) {
      // Add users in firebase auth.
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;

      if (user != null) {
        final uid = user.uid;

        // Add Users information in firestore.
        final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
        await docUser.set({
          'Tel': Tel,
          'address': address,
          'category_id': category_id,
          'city': city,
          'email': email,
          'name': name,
          'password': password,
          'uid': uid,
          'cart_id': '$email$uid',
        });
        // Add User cart id in firestore.
        final docCart =
            FirebaseFirestore.instance.collection('cart').doc('$email$uid');
        DateTime now = new DateTime.now();
        await docCart.set(
          {
            'uid': uid,
            'cart_id': '$email$uid',
            //'crop_ids': crop_ids,
            'date': now,
            'total_price': total_price, //
            'total_quantity': total_quantity, //
          },
        );
      }
    }
    MyToast.show('registration was successful!');
  }
}
