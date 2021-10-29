import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_bottom.dart';
import 'package:crop_sales_app/screen/cart/components/count_text.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crop_sales_app/styles/colors.dart';

import 'components/cart_list_class.dart';
import 'components/cart_list_page.dart';

class CartPageHome extends StatefulWidget {
  const CartPageHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPageHomeState();
  }
}

class _CartPageHomeState extends State {
  ///测试数据集合
  List<CartCropDetial> carts = [];
  int totalPrice = 0;
  bool _isButtonEdit = false;

  Future fetchCartCropList() async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    //print(uid_cartID);

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(uidCartID)
        .collection('crop_ids')
        .get();

    final List<CartCropDetial> carts =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData =
          document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String desc = cartListData['description'];
      final String url = cartListData['url'];
      final int maxcount = cartListData['maxBuyCount'];
      final int quantity = cartListData['quantity'];
      final int price = cartListData['price'];
      return CartCropDetial(id, name, desc, url, maxcount, quantity, price);
    }).toList();
    //print(carts);
    this.carts = carts;
    //print(this.carts);
    return carts;
  }

  @override
  void initState() {
    super.initState();
    fetchCartCropList();
    //print(carts);//null
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'My Cart',
      actions: <Widget>[
        //AppBarShopCartIconButton()
        FlatButton(
          color: _isButtonEdit ? Colors.white : Colors.white,
          //splashColor: Colors.transparent,
          onPressed: () {
            setState(
              () {
                _isButtonEdit = !_isButtonEdit;
                if (_isButtonEdit == true) {
                  MyToast.show('You can edit your own shopping list!');
                } else {
                  MyToast.show('You have confirmed your order!');
                }
              },
            );
          },
          child: Text(
            _isButtonEdit == true ? 'OK' : 'Edit',
            style: TextStyle(
                color: _isButtonEdit ? Colors.white : AppColors.priceColor),
          ),
        ),
      ],
      body: Column(
        children: <Widget>[
          Container(
            color: AppColors.primaryBackground,
            height: MediaQuery.of(context).size.height - 125,
            child: buildListView(),
          ),
          CartListBottom(),
        ],
      ),
    );
  }

  buildListView() {
    //fetchCartCropList();
    //print(carts);
    if (carts.isEmpty) {
      MyLoadingWidget();
      return const CartListPage();
    } else if (carts.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TestListItemWidget(
            crops: carts[index],
            key: GlobalObjectKey(index),
          );
        },
        itemCount: carts.length,
      );
    }
  }
}

class TestListItemWidget extends StatefulWidget {
  final CartCropDetial crops;

  const TestListItemWidget({required this.crops, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListItemState();
  }
}

class _ListItemState extends State<TestListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(
            child: buildColumn(),
          ),
        ],
      ),
    );
  }

  Column buildColumn() {
    final topWidth = MediaQuery.of(context).size.width;
    GlobalKey<TextWidgetState> textKey = GlobalKey();
    var _count = widget.crops.single_quantity;

    return Column(
      children: <Widget>[
        Container(
          height: 80.0,
          margin: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: CachedNetworkImage(
                  alignment: Alignment.center,
                  placeholder: (_, __) =>
                      Image.asset('assets/images/order/jiazaizhong.png'),
                  imageUrl: widget.crops.crop_imageURL,
                  height: 60,
                  width: 60,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// crop Name
                  SizedBox(
                    width: (topWidth - 236),
                    child: Text(
                      widget.crops.crop_name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),

                  /// crop ID
                  SizedBox(
                    width: (topWidth - 236),
                    child: Text(
                      widget.crops.crop_desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreyText),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// Inventory
                  SizedBox(
                    width: (topWidth - 236),
                    child: RichText(
                      text: TextSpan(
                        text: "Inventory: ",
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.crops.crop_maxBuyCount.toString(),
                            style: const TextStyle(
                              color: Color(0xFF121212),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: " Kg",
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// crop Price
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    //color: Colors.blue,
                    margin: const EdgeInsets.only(right: 5),
                    child: RichText(
                      text: TextSpan(
                        text: 'PHP ',
                        style: const TextStyle(
                          color: AppColors.priceColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: widget.crops.single_price.toString(),
                            style: const TextStyle(
                              color: AppColors.priceColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    //color: Colors.red,
                    height: 30,
                    margin: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          iconSize: 20,
                          onPressed: () {
                            if (_count <= 1) {
                              _count--;
                              deleteCrop(widget.crops.crop_id);
                              MyToast.show('Delete!');
                            } else {
                              _count--;
                              textKey.currentState!.onPressed(_count);
                              var totalPrice =
                                  widget.crops.single_price * _count;
                              eachCropTotalQuantityAndPrice(
                                  widget.crops.crop_id, _count, totalPrice);
                            }
                          },
                          color: Colors.deepOrange,
                          splashColor: AppColors.buyNow1,
                          highlightColor: Colors.blue[300],
                          padding: EdgeInsets.all(0), //tooltip: '??',
                        ),
                        TextWidget(textKey),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          iconSize: 20,
                          onPressed: () {
                            if (_count == widget.crops.crop_maxBuyCount) {
                              MyToast.show('Already the largest inventory!');
                            } else if (_count < widget.crops.crop_maxBuyCount) {
                              _count++;
                              textKey.currentState!.onPressed(_count);
                              var totalPrice =
                                  widget.crops.single_price * _count;
                              eachCropTotalQuantityAndPrice(
                                  widget.crops.crop_id, _count, totalPrice);
                            } else {}
                          },
                          color: Colors.deepOrange,
                          splashColor: AppColors.primaryBackground,
                          highlightColor: Colors.blue[300],
                          padding: EdgeInsets.all(0),
                          //tooltip: '??',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future deleteCrop(cropID) async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    print('Corp is deleted! ID: $cropID');
    // firestore delete
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(uidCartID)
        .collection('crop_ids')
        .doc(cropID)
        .delete();
  }

  Future eachCropTotalQuantityAndPrice(cropID, count, totalPrice) async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    print('Corp is updata!');
    print('ID: $cropID');
    print('No. $count');
    print('TotalPrice: $totalPrice');
    //print(totalPrice);

    await FirebaseFirestore.instance
        .collection('cart')
        .doc(uidCartID)
        .collection('crop_ids')
        .doc(cropID)
        .update({
      'quantity': count,
      'totalPrice': totalPrice.toString(),
    });
  }
}
