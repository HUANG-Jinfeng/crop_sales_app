import 'cart_crop_model.dart';

/// 品牌Model
class SellerItem {
  String sellerName;
  String sellerCompany;
  bool sellerSendByself;
  bool sellerSendBySend;
  bool isSellerChecked = false;
  List<CropItem> cropsList;
  SellerItem({
    required this.sellerName,
    required this.sellerCompany,
    required this.sellerSendByself,
    required this.sellerSendBySend,
    required this.cropsList,
    required this.isSellerChecked,
  });

  /// 计算每组品牌的总价格
  int getTotalMoney() {
    int total = 0;
    for (CropItem item in this.cropsList) {
      total += item.getTotalMoney();
    }
    return total;
  }

  /*
   * 判断品牌下面的子商品是否选中，
   * 如果选中则该品牌的 @isBrandChecked 参数应为true
   * */
  bool get isSomeOneGoodSelected {
    bool isSomeOneGoodSelected = false;
    for (CropItem item in this.cropsList) {
      if (item.cropIsChecked) {
        isSomeOneGoodSelected = true;
        break;
      }
    }
    return isSomeOneGoodSelected;
  }
}