import 'package:crop_sales_app/screen/main/components/my_bottom_navigation_bar.dart';
import 'package:crop_sales_app/screen/manage/manage_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
//import 'package:crop_sales_app/screen/category/category_page.dart';
import 'package:crop_sales_app/screen/order/order_page.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import '../home/home_page_buyer.dart';
import 'store/main_provider.dart';

class BuyerMainPage extends StatefulWidget {
  @override
  _BuyerMainPageState createState() => _BuyerMainPageState();
}

class _BuyerMainPageState extends State<BuyerMainPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  ///hide your splash screen
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 750), () {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mainState = Provider.of<MainProvider>(context, listen: false);
    MyNavigator.ctx = context;

    return ScreenUtilInit(
      designSize: Size(375, 812 - 44 - 34),
      builder: () => Scaffold(
        backgroundColor: Color(0xfffefefe),
        bottomNavigationBar: MyBottomNavigationBar(onTap: (index) {
          mainState.tabBarPageController.jumpToPage(index);
          setState(() {
            mainState.setTabBarSelectedIndex = index;
          });
        }),
        body: PageView(
          controller: mainState.tabBarPageController,
          children: <Widget>[BuyerHomePage(), /*CategoryPage(),*/ OrderPage(), ManagePage()],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
