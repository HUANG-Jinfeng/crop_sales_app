import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/order_detail/order_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

class OrderItem extends StatelessWidget {
  final orderItemData;
  const OrderItem({Key? key, this.orderItemData}) : super(key: key);

  Future<void> getOrderIDs () async {
    final uID = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data = uID.data();
    final String uidCartID = data?['cart_id'];
    final QuerySnapshot docOrderIDs = await FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .get();
    final List orderIDlist =
    docOrderIDs.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> orderIDlist =
      document.data() as Map<String, dynamic>;
    }).toList();

    print(orderIDlist.length);
    /*FirebaseFirestore.instance
        .collection('orders')
        .doc(uidCartID)
        .collection('orderIDs')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
              const Head(), // 头部
            ] +
            //控制显示的商品列表个数
            [1].map<Widget>((item) {
              return const Content();
            }).toList() +
            [const Bottom()] +
        [IconButton(onPressed: () {getOrderIDs();}, icon: Icon(Icons.add))],
      ),
    );
  }
}

///顶部Order ID
class Head extends StatelessWidget {
  const Head({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => MyNavigator.push(const OrderDetailPage(orderId: "id")),
      child: Container(
        padding: const EdgeInsets.all(15.0),
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
                const Text(
                  'Order ID: ',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF121212),
                  ),
                ),
                const SizedBox(width: 10.5),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xFF4A4A4A),
                  size: 20.0,
                ),
              ],
            ),
            const Text(
              'Paying',
              style: TextStyle(
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
}

/// 订单内容
class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyNavigator.push(OrderDetailPage(orderId: "id")),
      child: Container(
        height: 80.0,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                // color: Colors.red,
                child: CachedNetworkImage(
                  placeholder: (_, __) =>
                      Image.asset('assets/images/order/jiazaizhong.png'),
                  imageUrl:
                      'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/google/298/tomato_1f345.png',
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            const Positioned(
              left: 90,
              top: 13,
              child: Text(
                "Tomato",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF17191A)),
              ),
            ),
            const Positioned(
              left: 90,
              top: 35,
              right: 15,
              child: Text(
                "Famer A's stroe.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFAAB0B3)),
              ),
            ),
            Positioned(
              // 价格
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
              // 价格
              left: 145,
              top: 55.0,
              child: RichText(
                text: const TextSpan(
                    text: 'PHP ',
                    style: TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '2400',
                        style: TextStyle(
                          color: AppColors.priceColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              ),
            ),
            const Positioned(
              // 价格
              right: 20,
              top: 51.0,
              child: Text(
                'x5',
                style: TextStyle(
                  color: Color(0xFF17191A),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 底部
class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);
  // 弹出对话框
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
                      style:
                          TextStyle(color: Color(0xFF4A4A4A), fontSize: 14.0),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: const TextSpan(
                    text: 'There are',
                    style: TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' 5 ',
                        style: TextStyle(
                          color: Color(0xFFB80821),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'items in total.',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]),
              ),
              RichText(
                text: const TextSpan(
                    text: 'Total：',
                    style: TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'PHP 12000',
                        style: TextStyle(
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
            padding: EdgeInsets.only(top: 15, bottom: 20),
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
                        fontWeight: FontWeight.normal,
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
                    onPressed: () => {},
                    color: AppColors.primaryColor,
                    child: const Center(
                      child: Text(
                        'Pay immediately',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
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
}
