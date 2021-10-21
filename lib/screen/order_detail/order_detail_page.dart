
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:crop_sales_app/screen/order_detail/components/address.dart';
import 'package:crop_sales_app/screen/order_detail/components/delivery.dart';
import 'components/info.dart';
import 'components/item.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => _showCancelDialog(context),
            child: Center(
              child: Text(
                'Cancel order',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
      title: 'Order ',
      body: OrderDetailContainer(),
    );
  }

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
                    padding: EdgeInsets.only(bottom: 0.0, top: 20),
                    child: Text(
                      'Cancel Order?',
                      style:
                          TextStyle(color: Color(0xFF4A4A4A), fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            confirmContent: 'OK',
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
        });
  }
}

class OrderDetailContainer extends StatelessWidget {
  const OrderDetailContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF7F7F7),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
                bottom: 60 + MediaQuery.of(context).padding.bottom),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Address(),
                  OrderItem(),
                  OrderDetailInfo(),
                  //Delivery(),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 15,
            //top: 10,
            child: MyButton(
              text: 'Pay immediately',
              handleOk: () => MyNavigator.push(PayPage(orderId: "id")),
            ),
          ),
        ],
      ),
    );
  }
}
