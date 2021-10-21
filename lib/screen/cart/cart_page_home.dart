import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/cart_list_page.dart';
import 'package:crop_sales_app/screen/pay/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:crop_sales_app/screen/cart/store/shopping_cart_provider.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'components/cart_bottom.dart';
import 'components/cart_item.dart';
import 'components/cart_list_bottom.dart';
import 'components/cart_list_class.dart';
import 'components/cart_list_model.dart';

class CartPageHome extends StatefulWidget {
  @override
  _CartPageHomeState createState() => _CartPageHomeState();
}

class _CartPageHomeState extends State<CartPageHome> {
  final _provider = ShopingCartProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: BaseScaffold(
        title: 'My Cart',
        actions: <Widget>[
          Selector<ShopingCartProvider, Tuple2<Function, bool>>(
            builder: (_, tuple, __) {
              return IconButton(
                icon: Text(
                  tuple.item2 ? 'OK' : 'Edit',
                  style: TextStyle(
                      color: AppColors.primaryGreyText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () => tuple.item1(),
              );
            },
            selector: (_, provider) =>
                Tuple2(provider.changeEditMode, provider.isEditMode),
          ),
        ],
        body: const CartContainer(),
      ),
    );
  }
}

class CartContainer extends StatelessWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartListModel>(
        create: (_) => CartListModel()..fetchCartCropList(),
        child: Stack(
          children: <Widget>[
            Container(
              color: AppColors.primaryBackground,
              child: Center(
                child: Consumer<CartListModel>(
                  builder: (context, model, child) {
                    final List<CartCropDetial>? carts = model.carts;
                    if (carts == null) {
                      return MyLoadingWidget();
                    }
                    final List<Widget> widgets = carts
                        .map(
                          (cart) => Column(
                            children: <Widget>[
                                Container(
                                  height: 80.0,
                                  margin: EdgeInsets.only(
                                      left: 18.0,
                                      right: 18.0,
                                      top: 5.0,
                                      bottom: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 10.0,
                                        top: 5.0,
                                        bottom: 5.0,
                                        child: Container(
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
                                        top: 10,
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
                                        top: 33,
                                        child: Text(
                                          cart.crop_id,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryGreyText),
                                        ),
                                      ),

                                      /// crop Price
                                      Positioned(
                                          right: 15,
                                          top: 12.0,
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
                                                    text: cart.single_price
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.priceColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ]),
                                          )),
                                      Positioned(
                                        left: 90,
                                        bottom: 10.0,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Inventory: ",
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: cart.single_quantity
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xFF121212),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: " Kg",
                                                    style: TextStyle(
                                                      color: Color(0xFF121212),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                            ],
                          ),
                        )
                        .toList();
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
                  },
                ),
              ),
            ),
            CartListBottom(),
          ],
        ),
    );
  }
}
