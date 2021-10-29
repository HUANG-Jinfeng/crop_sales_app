import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/home/home_page_buyer.dart';
import 'package:crop_sales_app/screen/main/store/main_provider.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/middle.dart';
import 'components/top.dart';

class PayPage extends StatelessWidget {
  final String orderId;
  final int totalPrice;

  const PayPage({Key? key, required this.orderId, required this.totalPrice})
      : super(key: key);

  Future<bool> _showCancelDialog(BuildContext context) async {
    final result = await showDialog<int>(
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
                    child: Text(
                      'Confirm to give up payment?',
                      style:
                          TextStyle(color: Color(0xFF4A4A4A), fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            confirmContent: 'Continue',
            confirmTextColor: AppColors.priceColor,
            cancelContent: 'Cancel',
            isCancel: true,
          );
        });
    return result == 0;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadType: AppBarBackType.Back,
      onWillPop: () async {
        final isCancelPay = await _showCancelDialog(context);
        return isCancelPay;
      },
      title: 'Payment',
      body: PayPageContainer(context,orderId,totalPrice),
    );
  }

  PayPageContainer(BuildContext context, String orderId, int totalPrice) {
    return Container(
      color: Color(0xFFF7F7F7),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
                bottom: 70 + MediaQuery.of(context).padding.bottom),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Top(orderId: orderId,totalPrice: totalPrice,), Middle()],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 15,
            child: MyButton(
              text: 'Pay immediately',
              handleOk: () => _showSuccessDialog(context),
            ),
          ),
        ],
      ),
    );
  }
  void _showSuccessDialog(BuildContext context) async {
    MyDialog.showLoading('Paying', barrier: true);
    await Future.delayed(Duration(seconds: 2), () {});
    MyDialog.hideLoading();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          content: Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/confirm_order/dingdanchenggong.png'),
                Container(
                  padding: EdgeInsets.only(bottom: 0.0, top: 10),
                  child: Text(
                    'Payment successful',
                    style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          confirmContent: 'CheckOrder',
          confirmTextColor: AppColors.buyNow1,
          cancelContent: 'Purchase',
          isCancel: true,
          confirmCallback: () {
            // check order
            final mainProvder =
            Provider.of<MainProvider>(context, listen: false);
            mainProvder.setTabBarSelectedIndex = 1;
          },
          dismissCallback: () {
            // continue to shoping
            MyNavigator.pushAndRemove(BuyerHomePage());
          },
        );
      },
    );
  }
}