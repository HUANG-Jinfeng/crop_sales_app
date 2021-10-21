import 'dart:async';
import 'package:crop_sales_app/screen/cart/components/cart_seller_model.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_class.dart';
import 'package:crop_sales_app/screen/cart/components/cart_crop_class.dart';
import 'package:crop_sales_app/screen/cart/components/cart_crop_model.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopingCartProvider with ChangeNotifier {
  /// 是否选中全部商品
  bool _isSelectAllCrop = false;

  /// 选中的商品数量
  int _cropTotalNum = 0;

  /// 选中的商品的总价格
  int _cropTotalPrice = 0;

  /// 是否为编辑模式
  bool isEditMode = false;

  ShopingCartProvider() {
    changeCropState();
    changeBottomState();
  }

  /// 品牌列表
  List<SellerItem> _cropsList = [
    SellerItem(
      sellerName: 'Famer A',
      sellerCompany: "Farmer A's store.",
      sellerSendByself: false,
      sellerSendBySend: true,
      isSellerChecked: false,
      cropsList: [
        getCropList(),
      ],
    ),
  ];

  /// 获取_brandList
  List<SellerItem> get getSellerList => this._cropsList;

  /// 获取_isSelectAllGood
  bool get isSelectAllCrop => this._isSelectAllCrop;

  int get cropTotalNum => this._cropTotalNum;

  int get cropTotalPrice => this._cropTotalPrice;

  /*
   * @item GoodItem
   * 选择单个商品，
   * 先改变GoodItem自身的状态，
   * 再改变父BrandItem的状态，
   * 接着改变底部bottom的状态
   */
  void selectSingleCrop(CropItem item) {
    item.cropIsChecked = !item.cropIsChecked; // 改变自身的状态
    Future.microtask(() {
      changeCropState(); // 改变父BrandItem的状态
      changeBottomState(); // 改变底部bottom的状态
    });
  }

  /*
   * @index BrandItem
   * 选择某个BrandItem下面所有的商品
   * 先改变自身BrandItem的状态
   * 再改变BrandItem下面所有商品的状态
   * 接着改变底部bottom的状态
   */
  void selectSellerAllCrop(int index) {
    this._cropsList[index].isSellerChecked =
        !this._cropsList[index].isSellerChecked; // 改变自身的状态
    this._cropsList[index].cropsList.forEach((item) => item.cropIsChecked =
        this._cropsList[index].isSellerChecked); // 改变BrandItem下面所有商品的状态
    Future.microtask(() {
      changeBottomState(); // 改变底部bottom的状态
    });
  }

  /*
   * 当单选某项商品时，该项商品状态变更之后，再改变父BrandItem的状态
   */
  changeCropState() {
    this._cropsList.forEach((item) => {
          item.isSellerChecked =
              item.cropsList.any((item) => item.cropIsChecked)
        });
  }

  /*
   * 当单选某项商品时，该项商品状态变更之后，再改变底部bottom的状态
   */
  void changeBottomState() {
    this._isSelectAllCrop = this.getSellerList.every((item) {
      return item.cropsList.every((item) => item.cropIsChecked);
    });
    this._cropTotalNum = 0;
    this._cropTotalPrice = 0;
    this._cropsList.forEach((brandItem) => brandItem.cropsList.forEach((item) {
          if (item.cropIsChecked) {
            this._cropTotalNum += item.count;
            this._cropTotalPrice += item.getTotalMoney();
          }
        }));
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
   * 点击底部bottom的全选按钮
   * 先变更自身_isSelectAllGood的状态
   * 再变更每个brandItem的状态以及下面每个商品的状态
   */
  void selectAllCrop() {
    this._isSelectAllCrop = !this._isSelectAllCrop; // 变更自身_isSelectAllGood的状态
    this._cropsList.forEach((item) {
      item.isSellerChecked = this._isSelectAllCrop; // 再变更每个brandItem的状态
      item.cropsList.forEach((item) => item.cropIsChecked =
          this._isSelectAllCrop); // 再变更每个brandItem下面每个商品的状态
    });
    Future.microtask(() {
      changeBottomState(); // 改变底部bottom的状态
    });
  }

  void addOneCropItem(CropItem item, int value) {
    item.count += value;
    if (item.count < 1) {
      item.count = 1;
      MyToast.show('The number of commodities has reached a minimum.');
      return;
    }
    item.cropIsChecked = true;
    notifyListeners();

    Future.microtask(() {
      changeCropState(); // 改变父BrandItem的状态
      changeBottomState(); // 改变底部bottom的状态
    });
  }

  void changeEditMode() {
    this.isEditMode = !this.isEditMode;
    notifyListeners();
  }

  void deteleCrop() {
    this._cropsList.forEach((brandItem) {
      brandItem.isSellerChecked = false;
      for (var i = brandItem.cropsList.length - 1; i >= 0; i--) {
        if (brandItem.cropsList[i].cropIsChecked) {
          brandItem.cropsList.removeAt(i);
        }
      }
    });
    for (var i = this._cropsList.length - 1; i >= 0; i--) {
      if (this._cropsList[i].cropsList.length == 0) {
        this._cropsList.removeAt(i);
      }
    }
    Future.microtask(() {
      changeBottomState(); // 改变底部bottom的状态
    });
  }
}
