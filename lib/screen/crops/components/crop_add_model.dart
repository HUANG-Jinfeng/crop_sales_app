import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCropModel extends ChangeNotifier {
  String? crop_category_id;
  String? crop_id;
  String? crop_name;
  String? date;
  String? description;
  File? imageFile;
  String? memo;
  int? price;
  String? uid;
  int? volume;

  bool isLoading = false;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addCrop() async {
    if (crop_name == null || description == "") {
      throw 'The Description cannot be empty.';
    }
    if (price == null || price!.isNaN) {
      throw 'The Price cannot be empty.';
    }
    if (volume == null || price!.isNaN) {
      throw 'The Volume cannot be empty.';
    }

    final doc = FirebaseFirestore.instance.collection('crops').doc();
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser!.uid;

    String? imgURL;
    if (imageFile != null) {
      // storage updata
      final task = await FirebaseStorage.instance
          .ref('crops/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    DateTime now = DateTime.now();
    // firestore ni add
    await doc.set(
      {
        'crop_category_id': crop_category_id,
        'crop_id': doc.id,
        'crop_name': crop_name,
        'date': now,
        'description': description,
        'image': imgURL,
        'memo': memo,
        'price': price,
        'uid': uid,
        'volume': volume,
      },
    );
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
