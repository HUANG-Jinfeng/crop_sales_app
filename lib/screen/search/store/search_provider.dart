import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:crop_sales_app/model/goods.dart';
import 'package:crop_sales_app/model/search.dart';

class SearchPageProvider with ChangeNotifier {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  List<GoodsList> result = [];
  bool loading = true;

  SearchPageProvider() {
    /// 数据加载
    searchData(keyword: '');
    notifyListeners();
  }
  Future searchData({bool refresh = false, required String keyword}) async {
    // print(keyword);
    loading = true;

    /// 这里keyword有存在空的情况，后期需要判断
    SearchModel res = await searchData(keyword: keyword);

    /// 初次加载
    result = res.result;
    loading = false;

    /// 下拉刷新
    if (refresh) {
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }

  /// 上拉加载
  Future loadData({bool refresh = false, required String keyword}) async {
    SearchModel res = await searchData(keyword: keyword);
    result += res.result;
    if (result.length < 20) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    notifyListeners();
  }
}
