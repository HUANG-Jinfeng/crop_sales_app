import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'order_page_home.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();
    //getOrderIDs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadType: AppBarBackType.None,
      actions: const <Widget>[AppBarShopCartIconButton()],
      title: 'Order',
      body: buildOrder(),
    );
  }

  buildOrder() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: AppColors.primaryBackground,
            child: OrderPageOrder(),
          ),
        )
      ],
    );
  }
}
