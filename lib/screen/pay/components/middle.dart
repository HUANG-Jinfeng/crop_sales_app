import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';

class Middle extends StatelessWidget {
  const Middle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 32,
            child: Text(
              'Payment method',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Divider(color: Color(0xffdfdfdf), height: 0.5),
          _buildItem(
            title: 'Credit card',
            tip: '(Open.)',
            img: 'assets/images/pay/check.png',
          ),
          Divider(color: Color(0xffdfdfdf), height: 0.5),
          _buildItem(
            title: 'QR Code',
            tip: '(Not supported.)',
            img: 'assets/images/pay/uncheck.png',
          ),
        ],
      ),
    );
  }

  /// each one
  Widget _buildItem({
    required String title,
    required String tip,
    required String img,
  }) {
    TextStyle greyText = TextStyle(
      color: Color(0xFFBEBEBE),
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );
    TextStyle blackText = TextStyle(
      color: Color(0xFF121212),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: title == 'Credit card' ? blackText : blackText),
              Text(tip, style: greyText),
            ],
          ),
          Image.asset(img, width: 20, height: 20)
        ],
      ),
    );
  }
}
