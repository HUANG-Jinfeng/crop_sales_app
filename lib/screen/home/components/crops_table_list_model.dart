import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CropInfo crop = CropListModel() as CropInfo;

class CropInfo {
  String Crop_id;
  String Crop_name;
  String Crop_desc;
  String Crop_memo;
  String Crop_pic;
  String Price;
  String Date;
  String Crop_category_id;
  String Crop_volume;

  CropInfo(
    this.Crop_id,
    this.Crop_name,
    this.Crop_desc,
    this.Crop_memo,
    this.Crop_pic,
    this.Price,
    this.Date,
    this.Crop_category_id,
    this.Crop_volume,
  );
}

class CropListModel extends ChangeNotifier {
  List<CropInfo>? crops;

  void fetchCropList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('crops').get();

    final List<CropInfo> crops = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String Crop_id = document.id;
      final String Crop_name = data['Crop_name'];
      final String Crop_desc = data['Crop_desc'];
      final String Crop_memo = data['Crop_memo'];
      final String Crop_pic = data['Crop_pic'];
      final String Price = data['Price'];
      final String Date = data['Date'];
      final String Crop_category_id = data['Crop_category_id'];
      final String Crop_volume = data['Crop_volume'];
      return CropInfo(Crop_id, Crop_name, Crop_desc, Crop_memo, Crop_pic, Price,
          Date, Crop_category_id, Crop_volume);
    }).toList();

    this.crops = crops;
    notifyListeners();
  }
}
