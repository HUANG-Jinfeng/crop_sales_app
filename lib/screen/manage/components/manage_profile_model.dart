import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 创建 个人信息类
class ManageInfo {
  String uid;
  String name;
  String email;
  String city;
  String category_id;
  String address;
  String Tel;
  File imageFile;

  ManageInfo(
      this.uid,
      this.name,
      this.email,
      this.city,
      this.category_id,
      this.address,
      this.Tel,
      this.imageFile,
      );
}

/// 读取个人信息数据
/*class ManageProfileModel extends ChangeNotifier {
  List<ManageInfo>? manageinfo;

  void fetchList() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').get();

    final List<ManageProfileModel> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = data['uid'];
      final String title = data['title'];
      final String author = data['author'];
      final String? imgURL = data['imgURL'];
      return Book(id, title, author, imgURL);
    }).toList();

    this.books = books;
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }*/

/*  Future<int> receive_quantity() async{
    final ManageProfileModel user = await _auth.currentUser();
    var snapshot = await databaseReference.child(user.uid+"/buttons"+"/quantity").once();
    var result = snapshot.value; //get the value here
    print(result);
    return result;
  }
}*/


/*class ChangeProfileModel extends ChangeNotifier {
  String? uid;
  String? name;
  String? email;
  String? city;
  String? category_id;
  String? address;
  String? Tel;
  File? imageFile;

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

  Future ChangeName() async {
    if (name == null || name == "") {
      throw 'You did not enter a new name!';
    }

    if (Tel == null || Tel!.isEmpty) {
      throw 'You did not enter a new phone number!';
    }

    if (email == null || email!.isEmpty) {
      throw 'You did not enter a new email.';
    }

    final doc = FirebaseFirestore.instance.collection('users').doc();

    String? imgURL;
    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('books/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    // firestoreに追加
    await doc.set({
      'uid': uid,
      'neae': name,
      'email': email,
      'city': city,
      'category_id': category_id,
      'address': address,
      'tel': Tel,
      'imgURL': imgURL,
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}*/
