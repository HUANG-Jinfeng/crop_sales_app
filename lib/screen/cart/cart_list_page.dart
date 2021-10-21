import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/base_scaffold.dart';
import 'package:crop_sales_app/components/empty.dart';
import 'package:crop_sales_app/components/my_loading.dart';
import 'package:crop_sales_app/screen/crops/components/add_crop_page.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/cart_list_class.dart';
import 'components/cart_list_model.dart';

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

            if (carts == null) {
              return MyLoadingWidget();
            }
            final List<Widget> widgets = carts
                .map((cart) => Column(
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(top:5.0,bottom: 10.0),
                              color: Colors.white,
                              child: carts.length == 0
                                  ? Empty(
                                      img:
                                          'assets/images/shopping_cart/empty.png',
                                      tipText:
                                          'The shopping cart is empty, go shopping!',
                                      buttonText: 'Go shopping',
                                      buttonTap: () => MyNavigator.popToHome(),
                                    )
                                  : Container(
                                      height: 70.0,
                                      margin: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 10.0,
                                          bottom: 0.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
//color: AppColors.primaryBackground,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 10.0,
                                            top: 5.0,
                                            child: Container(
//color: Colors.red,
                                              child: CachedNetworkImage(
                                                placeholder: (_, __) => Image.asset(
                                                    'assets/images/order/jiazaizhong.png'),
                                                imageUrl: cart.crop_imageURL,
                                                height: 60,
                                                width: 60,
                                              ),
                                            ),
                                          ),

                                          /// crop Name
                                          Positioned(
                                            left: 90,
                                            top: 5,
                                            child: Text(
                                              cart.crop_name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryText),
                                            ),
                                          ),

                                          /// crop ID
                                          Positioned(
                                            left: 90,
                                            top: 28,
                                            child: Text(
                                              cart.crop_id,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .primaryGreyText),
                                            ),
                                          ),

                                          /// crop Price
                                          Positioned(
                                              right: 10,
                                              top: 8.0,
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'PHP ',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.priceColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: cart.single_price.toString(),
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .priceColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ]),
                                              )),
                                          Positioned(
// Inventory crop_volume
                                            left: 90,
                                            top: 50.0,
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
                                                    text: cart.single_quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Color(0xFF121212),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: " Kg",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF121212),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
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
