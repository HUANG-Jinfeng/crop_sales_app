import 'package:crop_sales_app/screen/pay/components/pay_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Top extends StatelessWidget {
  final String orderId;
  final int totalPrice;

  const Top({required this.orderId,required this.totalPrice,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 60, bottom: 10),
            child: Center(
              child: Text(
                'Order $orderId',
                style: const TextStyle(
                  color: Color(0xFF17191A),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'PHP ',
                  style: const TextStyle(
                    color: AppColors.priceColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: totalPrice.toString(),
                      style: const TextStyle(
                        color: AppColors.priceColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
