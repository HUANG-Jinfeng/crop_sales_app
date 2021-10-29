import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_page.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'components/cart_list_bottom.dart';
import 'components/cart_list_class.dart';
import 'components/cart_list_model.dart';

class CartPageHome extends StatefulWidget {
  @override
  _CartPageHomeState createState() => _CartPageHomeState();
}

class _CartPageHomeState extends State<CartPageHome> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: 'My Cart',
        body: const CartContainer(),
    );
  }
}

class CartContainer extends StatelessWidget {
  const CartContainer({Key? key, text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topWidth = MediaQuery.of(context).size.width; //宽度
    final topHeight = MediaQuery.of(context).size.height; //高度
    GlobalKey<_TextWidgetState> textKey = GlobalKey();

    return ChangeNotifierProvider<CartListModel>(
      create: (_) => CartListModel()..fetchCartCropList(),
      child: Stack(
        children: <Widget>[
          Container(
            color: AppColors.primaryBackground,
            child: Center(
              child: Consumer<CartListModel>(
                builder: (context, model, child) {
                  final List<CartCropDetial>? carts = model.carts;
                  int count = 1;
                  if (carts == null) {
                    return MyLoadingWidget();
                  }
                  final List<Widget> widgets = carts
                      .map(
                        (cart) => Column(
                          children: <Widget>[
                            Container(
                              height: 80.0,
                              margin: EdgeInsets.only(
                                  left: 18.0,
                                  right: 18.0,
                                  top: 10.0,
                                  bottom: 0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: CachedNetworkImage(
                                      alignment: Alignment.center,
                                      placeholder: (_, __) => Image.asset(
                                          'assets/images/order/jiazaizhong.png'),
                                      imageUrl: cart.crop_imageURL,
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /// crop Name
                                      Container(
                                        width: (topWidth - 236),
                                        child: Positioned(
                                          child: Text(
                                            cart.crop_name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryText),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),

                                      /// crop ID
                                      Container(
                                        width: (topWidth - 236),
                                        child: Positioned(
                                          child: Text(
                                            cart.crop_desc,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.primaryGreyText),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      /// Inventory
                                      Container(
                                        width: (topWidth - 236),
                                        child: Positioned(
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Inventory: ",
                                              style: TextStyle(
                                                color: AppColors.primaryText,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: cart.crop_maxBuyCount.toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFF121212),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: " Kg",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF121212),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /// crop Price
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        margin: EdgeInsets.only(right: 5),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'PHP ',
                                            style: TextStyle(
                                              color: AppColors.priceColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: cart.single_price
                                                    .toString(),
                                                style: TextStyle(
                                                  color: AppColors.priceColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Container(
                                        //color: Colors.red,
                                        height: 30,
                                        margin: EdgeInsets.only(right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline),
                                              iconSize: 20,
                                              onPressed: () {
                                                if (cart.single_quantity <= 1) {
                                                  MyToast.show(
                                                      'Error, minimum purchase is one.!');
                                                } else {
                                                  cart.single_quantity--; // 这里我们只给他值变动，状态刷新交给下面的Key事件
                                                  textKey.currentState!
                                                      .onPressed(cart
                                                          .single_quantity); //其实这个count值已经改变了 但是没有重绘所以我们看到的只是我们定义的初始值
                                                  var totalPrice =
                                                          cart.single_price *
                                                      cart.single_quantity;
                                                  model
                                                      .eachCropTotalQuantityAndPrice(
                                                          cart.crop_id,
                                                          cart.single_quantity,
                                                          totalPrice);
                                                  model
                                                      .cartTotalQuantityAndPrice(
                                                      cart.single_price*-1,
                                                      cart.single_quantity*-1);
                                                }
                                              },
                                              color: Colors.deepOrange,
                                              splashColor: AppColors.buyNow1,
                                              highlightColor: Colors.blue[300],
                                              padding: EdgeInsets.all(
                                                  0), //tooltip: '??',
                                            ),
                                            TextWidget1(textKey, cart.single_quantity),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.add_circle_outline),
                                              iconSize: 20,
                                              onPressed: () {
                                                if (cart.single_quantity <
                                                    int.parse(cart
                                                        .crop_maxBuyCount.toString())) {
                                                  cart.single_quantity++;
                                                  textKey.currentState!
                                                      .onPressed(
                                                          cart.single_quantity);
                                                  var totalPrice =
                                                          cart.single_price *
                                                      cart.single_quantity;
                                                  model
                                                      .eachCropTotalQuantityAndPrice(
                                                          cart.crop_id,
                                                          cart.single_quantity,
                                                          totalPrice);
                                                  model
                                                      .cartTotalQuantityAndPrice(
                                                          cart.single_price,
                                                          cart.single_quantity);
                                                } else if (cart
                                                        .single_quantity ==
                                                    int.parse(cart
                                                        .crop_maxBuyCount.toString())) {
                                                  MyToast.show(
                                                      'Already the largest inventory!');
                                                };
                                              },
                                              color: Colors.deepOrange,
                                              splashColor: AppColors.buyNow1,
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
                        ),
                      )
                      .toList();
                  if (carts.isEmpty) {
                    return Empty(
                      img: 'assets/images/shopping_cart/empty.png',
                      tipText: 'The shopping cart is empty, go shopping!',
                      buttonText: 'Go shopping',
                      buttonTap: () => MyNavigator.pop(),
                    );
                  } else {
                    return ListView(
                      children: widgets,
                    );
                  }
                },
              ),
            ),
          ),
          CartListBottom(),
        ],
      ),
    );
  }
}

class TextWidget1 extends StatefulWidget {
  final Key key;
  const TextWidget1(this.key, this.title);
  final int title;

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget1> {
  String text = '1';

  void onPressed(title) {
    setState(() {
      text = title.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black54),
      ),
    );
  }
}
