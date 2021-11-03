import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:provider/provider.dart';
import 'components/order_list_class.dart';
import 'components/order_list_model.dart';

class OrderPageOrder extends StatefulWidget {
  const OrderPageOrder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPageHomeState();
  }
}

class _CartPageHomeState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderListModel>(
      create: (_) => OrderListModel()..fetchOrderCropList(),
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Consumer<OrderListModel>(
          builder: (context, model, child) {
            final List<OrderDetail>? orderCarts = model.orderCarts;
            final Orders? orderInfo = model.orders;

            if (orderCarts == null && orderInfo == null) {
              return MyLoadingWidget();
            } else {
              return Column(
                children: <Widget>[
                  buildHead(orderInfo!.order_id, orderInfo.order_state),
                  SizedBox(
                    height: orderCarts!.length * 80,
                    child: buildListView(orderCarts),
                  ),
                  buildBottom(
                      orderInfo.order_id,
                      orderInfo.order_total_quantity,
                      orderInfo.order_total_price),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  buildListView(orderCarts) {
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

  buildHead(orderID, orderState) {
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
                  orderID,
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

  buildBottom(String orderID, int orderTotalQuantity, int orderTotalPrice) {
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
                        text: orderTotalQuantity.toString(),
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
                        text: 'PHP ${orderTotalPrice.toString()}',
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
                    onPressed: () => {
                      MyNavigator.push(PayPage(
                        orderId: orderID,
                        totalPrice: orderTotalPrice,
                      )),
                    },
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
            ///
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
