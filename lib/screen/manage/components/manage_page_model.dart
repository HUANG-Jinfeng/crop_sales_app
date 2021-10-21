import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyManageModel extends ChangeNotifier {
  bool isLoading = false;

  String? uid;
  String? name;
  String? email;
  String? city;
  String? category_id;
  String? address;
  String? Tel;
  //File imageFile;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    this.email = user?.email;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();
    this.name = data?['name'];
    this.email = data?['email'];
    this.city = data?['city'];
    this.category_id = data?['categroy_id'];
    this.address = data?['address'];
    this.Tel =data?['Tel'];
    //this.description = data?['description'];
    //print('用户快照：{$data}');

    notifyListeners();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);

    MyToast.show('Logout successfully!');
  }
}