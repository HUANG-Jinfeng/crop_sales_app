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