import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'cart_crop_class.dart';

///  商品Model
class CropItem {
  Crop crop;
  bool cropIsChecked = false;
  int count = 1; // 商品的个数
  CropItem({required this.crop, required this.cropIsChecked, required this.count});
  /// 计算当前单项商品的总价格
  int getTotalMoney() {
    return count * this.crop.price;
  }
  /// 判断数量是否超出库存
  bool get isBiggerQuantity {
    return this.count < this.crop.stockQuantity;
  }
}

CropItem getCropList() {
  return CropItem(
    cropIsChecked: false,
    crop: Crop(
      cropsId: 'goodsId1',
      cropsName: 'Tomato',
      imageUrl: 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/google/298/tomato_1f345.png',
      minBuyCount: '1',
      stockQuantity: 15,
      price: 2400,
    ),
    count: 1,
  );
}
/// Make a data
/*fetchCartCropList() async {
  final uid_cartID =
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  final data = uid_cartID.data();
  final String uid_cropID = data?['cart_id'];
  print(uid_cropID);

  final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('cart').doc(uid_cropID).collection('crop_ids').get();

  final List<Crop> carts = snapshot.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> cartListData = document.data() as Map<String, dynamic>;
    final String cropsId = cartListData['id'];
    final String cropsName = cartListData['name'];
    final String imageUrl = cartListData['url'];
    final String minBuyCount = cartListData['minBuyCount'];
    final int stockQuantity = cartListData['quantity'];
    final int price = cartListData['price'];
    return Crop(
        cropsId,
        cropsName,
        imageUrl,
        minBuyCount,
        stockQuantity,
        price,
    );
  }).toList();
}*/
