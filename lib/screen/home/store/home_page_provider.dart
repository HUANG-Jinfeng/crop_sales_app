import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageProvider with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  bool loading = true;
}
