import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/screen/main/store/main_provider.dart';
import 'package:crop_sales_app/screen/order/components/order_item.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ["All", "Paying", "Delivering", "Finished"];

  @override
  void initState() {
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadType: AppBarBackType.None,
      actions: <Widget>[AppBarShopCartIconButton()],
      title: 'Order',
      body: OrderPageContainer(tabController: _tabController, tabs: tabs),
    );
  }
}

class OrderPageContainer extends StatelessWidget {
  const OrderPageContainer({
    Key? key,
    required TabController tabController,
    required this.tabs,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List tabs;

  @override
  Widget build(BuildContext context) {
    List orderList = [1];//数组控制订单数量
    final mainProvder = Provider.of<MainProvider>(context, listen: false);

    return Column(
      children: <Widget>[
        _buildTab(),
        Expanded(
          child: Container(
            color: Color(0xFFF7F7F7),
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((_) {
                return orderList.length == 0
                    ? Empty(
                        img: 'assets/images/order/empty.png',
                        tipText: 'No order.',
                        buttonText: 'Please go buy.',
                        buttonTap: () =>
                            {mainProvder.setTabBarSelectedIndex = 0},
                      )
                    : ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return OrderItem(orderItemData: orderList[index]);
                        });
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTab() {
    return Container(
      height: 49,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppColors.buttonLine1,
        unselectedLabelColor: AppColors.primaryGreyText,
        tabs: tabs
            .map((e) => Container(
                  child: Tab(text: e),
                ))
            .toList(),
      ),
    );
  }
}
