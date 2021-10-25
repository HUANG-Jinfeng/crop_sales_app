import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPageProvider with ChangeNotifier {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  bool loading = true;

  SearchPageProvider() {
    /// Data Loading
    searchData(keyword: '');
    notifyListeners();
  }
  Future searchData({bool refresh = false, required String keyword}) async {
    // print(keyword);
    loading = true;

    /// 下拉刷新
    if (refresh) {
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }

}
