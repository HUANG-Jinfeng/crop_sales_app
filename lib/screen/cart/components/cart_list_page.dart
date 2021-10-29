import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/empty.dart';
import 'package:crop_sales_app/components/my_loading.dart';
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
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          placeholder: (_, __) =>
                              Image.asset('assets/images/order/jiazaizhong.png'),
                          imageUrl: cart.crop_imageURL,
                          height: 60,
                          width: 60,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /// crop Name
                          SizedBox(
                            width: (topWidth - 236),
                            child: Text(
                              cart.crop_name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryText),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          /// crop ID
                          SizedBox(
                            width: (topWidth - 236),
                            child: Text(
                              cart.crop_desc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryGreyText),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// Inventory
                          SizedBox(
                            width: (topWidth - 236),
                            child: RichText(
                              text: TextSpan(
                                text: "Inventory: ",
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: cart.crop_maxBuyCount.toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF121212),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: const <TextSpan>[
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /// crop Price
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            //color: Colors.blue,
                            margin: const EdgeInsets.only(right: 5),
                            child: RichText(
                              text: TextSpan(
                                text: 'PHP ',
                                style: const TextStyle(
                                  color: AppColors.priceColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: cart.single_price.toString(),
                                    style: const TextStyle(
                                      color: AppColors.priceColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Container(
                            //color: Colors.red,
                            height: 30,
                            margin: const EdgeInsets.only(right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  iconSize: 20,
                                  onPressed: () {},
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(0), //tooltip: '??',
                                ),
                                Text(cart.single_quantity.toString(),style: Theme.of(context).textTheme.bodyText1, ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  iconSize: 20,
                                  onPressed: () {},
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(0),
                                  //tooltip: '??',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ) //Text(book.title),
                    )
                .toList() + [];
            if (carts.isEmpty) {
              return Empty(
                img: 'assets/images/shopping_cart/empty.png',
                tipText: 'The shopping cart is empty, go shopping!',
                buttonText: 'Go shopping',
                buttonTap: () => MyNavigator.popToHome(),
              );
            } else {
              return ListView(
                children: widgets,
              );
            }
          }),
        ),
      ),
    );
  }
}
