import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:crop_sales_app/model/goods.dart';
import 'package:crop_sales_app/model/home.dart';

class ManagePageProvider with ChangeNotifier {
  bool loading = true;
  List<GoodsList> hotList = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
}
