import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/cart_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:crop_sales_app/screen/cart/store/shopping_cart_provider.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'components/cart_bottom.dart';
import 'components/cart_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                  style: TextStyle(color: AppColors.primaryGreyText, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                onPressed: () => tuple.item1(),
              );
            },
            selector: (_, provider) => Tuple2(provider.changeEditMode, provider.isEditMode),
          ),
        ],
        body: const CartContainer(),
        //body: const CartListPage(),
      ),
    );
  }
}

class CartContainer extends StatelessWidget {
  const CartContainer({Key? key}) : super(key: key);
  Widget _listItemBuilder(BuildContext context, int index) {
    // 取出数据
    final sellerList = Provider.of<ShopingCartProvider>(context).getSellerList;

    return Container(
      color: Color(0xFFF5F7F7),
      padding: EdgeInsets.all(10.0),
      child: CartItem(sellerData: sellerList[index], sellerIndex: index),
      //child: CartListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 取出数据
    final sellerList = Provider.of<ShopingCartProvider>(context).getSellerList;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 80.0),
          color: Color(0xFFF5F7F7),
          child: sellerList.length == 0
              ? Empty(
                  img: 'assets/images/shopping_cart/empty.png',
                  tipText: 'The shopping cart is empty, go shopping!',
                  buttonText: 'Go shopping',
                  buttonTap: () => MyNavigator.popToHome(),
                )
              : ListView.builder(
                  itemCount: sellerList.length,
                  itemBuilder: _listItemBuilder,
                ),
        ),
        CartBottom(),
      ],
    );
  }
}
