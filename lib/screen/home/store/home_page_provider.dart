import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:crop_sales_app/model/goods.dart';
import 'package:crop_sales_app/model/home.dart';

class HomePageProvider with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  bool loading = true;
 /*List<Crop>? crops = [];
  //List<String> banerList = [];
  //List<BrandListElement> cateGoryList = [];
  //List<BrandListElement> brandList = [];
  //List<GoodsList> hotList = [];

  HomePageProvider() {
    /// 首页数据加载
    initData();
  }

  Future initData({bool refresh = false}) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        'crops').get();

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
      return Crop(
          crop_category_id,
          crop_id,
          crop_name,
          date,
          description,
          image,
          memo,
          price,
          volume);
    }).toList();

    this.crops = crops;
    notifyListeners();
  }*/

}
