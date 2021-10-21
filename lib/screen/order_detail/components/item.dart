import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

class OrderItem extends StatelessWidget {
  final orderItemData;
  const OrderItem({Key? key, this.orderItemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
              Head(), // 头部
            ] +
            [1].map<Widget>((item) {
              return Content();
            }).toList(),
      ),
    );
  }
}

///顶部供应商
class Head extends StatelessWidget {
  const Head({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      //onTap: () => MyNavigator.push(SupplierPage(supplierId: "supplierId")),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Famer A',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF121212),
                  ),
                ),
                SizedBox(width: 10.5),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xFF4A4A4A),
                  size: 20.0,
                ),
              ],
            ),
            Text(
              'Paying',
              style: TextStyle(
                fontSize: 15.0,
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
    return Container(
      height: 89.0,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 15,
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
          Positioned(
            left: 90,
            right: 15,
            top: 16,
            child: Text(
              "Tomoto",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF17191A)),
            ),
          ),
          Positioned(
            left:90,
            top: 40,
            right: 15,
            child: Text(
              'Detail',
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
            top: 61.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
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
            top: 61.0,
            child: RichText(
              text: TextSpan(
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
          Positioned(
            // 价格
            right: 20,
            top: 61.0,
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
    );
  }
}
