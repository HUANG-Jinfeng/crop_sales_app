import 'package:crop_sales_app/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/screen/cart/store/shopping_cart_provider.dart';

import 'cart_seller_model.dart';
import 'cart_crop_model.dart';

class CartItem extends StatelessWidget {
  // 取出每个品牌的数据
  final SellerItem sellerData;
  final int sellerIndex;
  final bool isShowCheckButton; // 是否显示选择按钮

  const CartItem({
    Key? key,
    required this.sellerData,
    required this.sellerIndex,
    this.isShowCheckButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 取出方法
    final selectSellerAllGood =
        Provider.of<ShopingCartProvider>(context, listen: false)
            .selectSellerAllCrop;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
              Head(
                sellerData: sellerData,
                selectedAllCrop: () => selectSellerAllGood(sellerIndex),
                isShowCheckButton: isShowCheckButton,
              ), // 头部
            ] +
            sellerData.cropsList.map<Widget>((CropItem item) {
              return Content(
                cropData: item,
                isShowCheckButton: isShowCheckButton,
              );
            }).toList(),
      ),
    );
  }
}

class Head extends StatelessWidget {
  final SellerItem sellerData;
  final Function selectedAllCrop;
  final bool isShowCheckButton; // 是否显示选择按钮
  const Head({
    Key? key,
    required this.sellerData,
    required this.selectedAllCrop,
    this.isShowCheckButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          height: 63,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: isShowCheckButton,
                    child: GestureDetector(
                      onTap: () => selectedAllCrop,
                      child: sellerData.isSellerChecked
                          ? Image.asset(
                              'assets/images/shopping_cart/check.png',
                              width: 20.0,
                              height: 36.0,
                            )
                          : Image.asset(
                              'assets/images/shopping_cart/check_un.png',
                              width: 20.0,
                              height: 36.0,
                            ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Visibility(
                          visible: isShowCheckButton,
                          child: Text(
                            sellerData.sellerName,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF17191A),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              isShowCheckButton
                                  ? (Image.asset(
                                      'assets/images/shopping_cart/icon-sj-26.png',
                                      height: 13.0,
                                      width: 13.0,
                                    ))
                                  : (Image.asset(
                                      'assets/images/shopping_cart/icon-sj-26.png',
                                      height: 20.0,
                                      width: 20.0,
                                    )),
                              Visibility(
                                visible: !isShowCheckButton,
                                child: SizedBox(width: 5),
                              ),
                              Text(
                                sellerData.sellerCompany,
                                style: isShowCheckButton
                                    ? TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFAAB0B3),
                                      )
                                    : TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF17191A),
                                      ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    sellerData.sellerSendByself
                        ? Container(
                            decoration: BoxDecoration(
                              color: AppColors.deliveryBackColor1,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            margin: EdgeInsets.only(right: 5.0),
                            padding: EdgeInsets.only(
                                top: 2.0, right: 5.0, bottom: 2.0, left: 5.0),
                            child: Text(
                              'Self-pickup',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.deliveryColor1,
                              ),
                            ),
                          )
                        : Container(),
                    sellerData.sellerSendBySend
                        ? Container(
                            decoration: BoxDecoration(
                              color: AppColors.deliveryBackColor2,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            margin: EdgeInsets.only(right: 5.0),
                            padding: EdgeInsets.only(
                                top: 2.0, right: 5.0, bottom: 2.0, left: 5.0),
                            child: Text(
                              'Express',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.deliveryColor2,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(color: Color(0xffdfdfdf), height: 1, indent: 10, endIndent: 10),
      ],
    );
  }
}

class Content extends StatelessWidget {
  final CropItem cropData;
  final bool isShowCheckButton; // 是否显示选择按钮
  const Content({
    Key? key,
    required this.cropData,
    this.isShowCheckButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 取出方法
    final selectSingleCrop =
        Provider.of<ShopingCartProvider>(context, listen: false)
            .selectSingleCrop;
    final addOneCropItem =
        Provider.of<ShopingCartProvider>(context, listen: false).addOneCropItem;
    return Container(
      height: 102.0,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 40,
            child: Visibility(
              visible: isShowCheckButton,
              child: GestureDetector(
                onTap: () => selectSingleCrop(cropData),
                child: cropData.cropIsChecked
                    ? Image.asset(
                        'assets/images/shopping_cart/check.png',
                        width: 20.0,
                        height: 40.0,
                      )
                    : Image.asset(
                        'assets/images/shopping_cart/check_un.png',
                        width: 20.0,
                        height: 40.0,
                      ),
              ),
            ),
          ),

          Positioned(
            left: 40,
            top: 15,
            child: Container(
              child: Image.network(
                cropData.crop.imageUrl,
                height: 60,
                width: 60,
              ),
            ),
          ),
          Positioned(
            left: 120,
            right: 23.5,
            top: 16,
            child: Text(
              cropData.crop.cropsName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF17191A)),
            ),
          ),
          /*Positioned(
            left: 120,
            top: 40,
            right: 23.5,
            child: Text(
              goodData.good.goodsDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400, color: Color(0xFFAAB0B3)),
            ),
          ),*/
          cropData.isBiggerQuantity
              ? Positioned(
                  // 价格
                  left: 120,
                  top: 43.5,
                  child: Text(
                    'PHP ' + cropData.crop.price.toString(),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF17191A),
                    ),
                  ),
                )
              : Positioned(
                  // 超出库存
                  left: 120,
                  top: 43.5,
                  child: Text(
                    'Out of stock.',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE61717),
                    ),
                  ),
                ),
          Positioned(
            // 价格
            left: 120,
            top: 58.5,
            child: Text(
              'Remaining：' + cropData.crop.stockQuantity.toString(),
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFFAAB0B3),
              ),
            ),
          ),
          Positioned(
            height: 30,
            width: 150,
            bottom: 26,
            right: 0,
            child: Container(
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Minus button
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => addOneCropItem(cropData, -1),
                    child: Image.asset(
                      cropData.count == 1
                          ? 'assets/images/shopping_cart/down1.png'
                          : 'assets/images/shopping_cart/down.png',
                      width: 36.0,
                      height: 28.0,
                    ),
                  ),
                  Container(
                    width: 45.0,
                    height: 28.0,
                    color: Color(0xFFF5F7F7),
                    child: Center(
                      child: Text(
                        cropData.count.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF17191A),
                        ),
                      ),
                    ),
                  ),
                  // Plus button
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => addOneCropItem(cropData, 1),
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'assets/images/shopping_cart/up.png',
                        width: 36.0,
                        height: 28.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
