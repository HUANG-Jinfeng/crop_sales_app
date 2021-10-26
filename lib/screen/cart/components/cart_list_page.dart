import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/base_scaffold.dart';
import 'package:crop_sales_app/components/empty.dart';
import 'package:crop_sales_app/components/my_loading.dart';
import 'package:crop_sales_app/screen/crops/components/crop_add_page.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_list_class.dart';
import 'cart_list_model.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartListModel>(
      create: (_) => CartListModel()..fetchCartCropList(),
      child: Scaffold(
        body: Center(
          child: Consumer<CartListModel>(builder: (context, model, child) {
            final List<CartCropDetial>? carts = model.carts;
            final topWidth = MediaQuery.of(context).size.width;

            if (carts == null) {
              return MyLoadingWidget();
            }
            final List<Widget> widgets = carts
                .map((cart) => Column(
              children: <Widget>[
                Container(
                  height: 80.0,
                  margin:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          placeholder: (_, __) =>
                              Image.asset('assets/images/order/jiazaizhong.png'),
                          imageUrl: cart.crop_imageURL,
                          height: 60,
                          width: 60,
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /// crop Name
                            Container(
                              width: (topWidth - 236),
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
                            SizedBox(
                              height: 2,
                            ),

                            /// crop ID
                            Container(
                              width: (topWidth - 236),
                              child: Text(
                                cart.crop_desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGreyText),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            /// Inventory
                            Container(
                              width: (topWidth - 236),
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
                                      text: cart.crop_maxBuyCount,
                                      style: TextStyle(
                                        color: Color(0xFF121212),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " Kg",
                                          style: TextStyle(
                                            color: Color(0xFF121212),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
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
                                      text: cart.single_price.toString(),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline),
                                    iconSize: 20,
                                    onPressed: () {
                                    },
                                    color: Colors.white,
                                    splashColor: AppColors.buyNow1,
                                    highlightColor: Colors.blue[300],
                                    padding: EdgeInsets.all(0), //tooltip: '??',
                                  ),
                                  Text(cart.single_quantity.toString(),style: Theme.of(context).textTheme.bodyText1, ),
                                  IconButton(
                                    icon: Icon(Icons.add_circle_outline),
                                    iconSize: 20,
                                    onPressed: () {
                                    },
                                    color: Colors.white,
                                    splashColor: AppColors.primaryBackground,
                                    highlightColor: Colors.blue[300],
                                    padding: EdgeInsets.all(0),
                                    //tooltip: '??',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ) //Text(book.title),
                    )
                .toList() + [];
            return ListView(
              children: widgets,
            );
          }),
        ),
      ),
    );
  }
}
