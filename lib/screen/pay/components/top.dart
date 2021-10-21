import 'package:crop_sales_app/screen/pay/components/pay_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PayModel>(
      create: (_) => PayModel()..readTotalPrice(),
      child: Consumer<PayModel>(
        builder: (context, model, child) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60, bottom: 10),
                  child: Center(
                    child: Text(
                      'Order amount',
                      style: TextStyle(
                        color: Color(0xFF17191A),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'PHP ',
                        style: TextStyle(
                          color: AppColors.priceColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: model.PRICE.toString(),
                            style: TextStyle(
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
        },
      ),
    );
  }
}
