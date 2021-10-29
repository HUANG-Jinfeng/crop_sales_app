import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_bottom.dart';
import 'package:crop_sales_app/screen/cart/components/count_text.dart';
import 'package:crop_sales_app/screen/order_detail/order_detail_page.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:provider/provider.dart';
import 'components/order_list_class.dart';

class OrderPageOrder extends StatefulWidget {
  const OrderPageOrder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPageHomeState();
  }
}

class _CartPageHomeState extends State {
  List<OrderDetail> orderCarts = [];
  String uid = '';
  String order_id = '';
  String order_state = '';
  bool isPay = false;
  int order_total_quantity = 0;
  int order_total_price = 0;

  Future fetchOrderCropList() async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];

    final orderIDs = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .get();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .doc(orderIDs.docs.last.id)
        .collection('OrderCropList')
        .get();
    final List<OrderDetail> crops =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> cartListData =
          document.data() as Map<String, dynamic>;
      final String id = cartListData['id'];
      final String name = cartListData['name'];
      final String desc = cartListData['description'];
      final String url = cartListData['url'];
      final int price = cartListData['price'];
      final int quantity = cartListData['quantity'];
      return OrderDetail(id, name, desc, url, price, quantity);
    }).toList();
    orderCarts = crops;
    return crops;
  }

  Future fetchOrder() async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];

    final orderIDs = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .get();
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .doc(orderIDs.docs.last.id)
        .get();
    final orderDetial = snapshot.data();
    this.uid = orderDetial?['uid'];
    this.order_id = orderDetial?['order_id'];
    this.order_state = orderDetial?['order_state'];
    this.isPay = orderDetial?['isPay'];
    this.order_total_quantity = orderDetial?['order_total_quantity'];
    this.order_total_price = orderDetial?['order_total_price'];
    print('orderID: $order_id');
  }

  @override
  void initState() {
    fetchOrderCropList();
    fetchOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          buildHead(order_id,order_state),
          Container(
            color: Colors.white,
            height: orderCarts.length * 80,
            child: buildListView(orderCarts),
          ),
          buildBottom(order_total_quantity,order_total_price),
        ],
      ),
    );
  }

  buildListView(List orderCarts) {
    //fetchCartCropList();
    //print(carts);
    if (orderCarts.isEmpty) {
      return MyLoadingWidget();
      //return const OrderListPage();
    } else if (orderCarts.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TestListItemWidget(
            crops: orderCarts[index],
            key: GlobalObjectKey(index),
          );
        },
        itemCount: orderCarts.length,
      );
    }
  }
  buildHead(String orderId, String orderState) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      //onTap: () => MyNavigator.push(const OrderDetailPage(orderId: "id")),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Image.asset('assets/images/home/shop.png',
                      width: 20.0, height: 20.0),
                ),
                const SizedBox(width: 10.5),
                Text(
                  orderId,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF121212),
                  ),
                ),
                const SizedBox(width: 10.5),
              ],
            ),
            Text(
              orderState,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  buildBottom(int order_total_quantity, int order_total_price) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      //color: Colors.red,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: 'There are ',
                    style: const TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: order_total_quantity.toString(),
                        style: const TextStyle(
                          color: AppColors.buyNow1,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(
                        text: ' items in total.',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Total：',
                    style: const TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'PHP ${order_total_price.toString()}',
                        style: const TextStyle(
                          color: AppColors.priceColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlineButton(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onPressed: () => _showCancelDialog(context),
                  splashColor: AppColors.splashColor,
                  highlightElevation: 5.0,
                  child: const Center(
                    child: Text(
                      'Cancel order',
                      style: TextStyle(
                        color: Color(0xFF121212),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: FlatButton(
                    //minWidth: 100,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: () =>
                        MyNavigator.push(PayPage(orderId: order_id, totalPrice: order_total_price,)),
                    color: AppColors.primaryColor,
                    child: const Center(
                      child: Text(
                        'Pay immediately',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          title: '',
          content: Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/order/querendingdan.png'),
                Container(
                  padding: const EdgeInsets.only(bottom: 0.0, top: 20),
                  child: const Text(
                    'Cancel order',
                    style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          confirmContent: 'Ok',
          cancelContent: 'Return',
          isCancel: true,
          // confirmColor: Color(0xFFF5A623),
          confirmCallback: () {
            /// 取消订单操作
          },
          dismissCallback: () {
            return;
          },
        );
      },
    );
  }
}

class TestListItemWidget extends StatefulWidget {
  final OrderDetail crops;
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
            child: buildContainer(),
          ),
        ],
      ),
    );
  }
  buildContainer() {
    return Container(
      height: 80.0,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              child: CachedNetworkImage(
                placeholder: (_, __) =>
                    Image.asset('assets/images/order/jiazaizhong.png'),
                imageUrl: widget.crops.url,
                height: 60,
                width: 60,
              ),
            ),
          ),
          Positioned(
            left: 90,
            top: 13,
            child: Text(
              widget.crops.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF17191A)),
            ),
          ),
          Positioned(
            left: 90,
            top: 35,
            right: 15,
            child: Text(
              widget.crops.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFAAB0B3)),
            ),
          ),
          Positioned(
            left: 90,
            top: 55.0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                'Price',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Positioned(
            left: 145,
            top: 55.0,
            child: RichText(
              text: TextSpan(
                  text: 'PHP ',
                  style: const TextStyle(
                    color: Color(0xFF121212),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.crops.price.toString(),
                      style: const TextStyle(
                        color: AppColors.priceColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ]),
            ),
          ),
          Positioned(
            right: 20,
            top: 51.0,
            child: RichText(
              text: TextSpan(
                text: 'x',
                style: const TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.crops.quantity.toString(),
                    style: const TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}