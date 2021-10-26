import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_page.dart';
import 'package:crop_sales_app/screen/crops/components/crop_add_page.dart';

import 'package:crop_sales_app/screen/main/initial_page.dart';
import 'package:crop_sales_app/screen/manage/components/manage_page_model.dart';
import 'package:crop_sales_app/screen/order/order_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/manage_address.dart';
import 'components/manage_profile_detail.dart';

class BuyerManagePage extends StatelessWidget {
  final String? supplierId;

  const BuyerManagePage({Key? key, this.supplierId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyManageModel>(
      create: (_) => MyManageModel()..fetchUser(),
      child: Scaffold(
        body: Center(
          child: Consumer<MyManageModel>(builder: (context, model, child) {
            return CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: Stack(
                  children: <Widget>[
                    _buildTop(context),
                    _buildFunc(context),
                    //_buildMoreFunc(context),
                  ],
                ),
              ),
            ]);
          }),
          //color: AppColors.primaryBackground,
        ),
        backgroundColor: AppColors.primaryBackground,
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Consumer<MyManageModel>(builder: (context, model, child) {
      return Container(
        padding: EdgeInsets.only(
            left: 20, top: MediaQuery.of(context).padding.top + 50),
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.supplierColor2, AppColors.supplierColor1],
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 90,
              child: Row(
                children: <Widget>[
                  Container(
                    //height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset(
                      "assets/images/manage/3x/pngegg.png",
                      //height: 80,
                      //width: 80,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.name ?? 'No name',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                        /*Text('ID: ${model.uid}' ?? 'null',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),*/
                        const Divider(height: 8),
                        Text(
                            'Tel: ${model.Tel}',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 12)),
                        //Divider(height: 5),
                        Text('Email: ${model.email}',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 12)),
                        //Divider(height: 5),
                        Text('City: ${model.city}',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              //width: 0.0,
              height: 90,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(0, 6, 10, 6),
                icon: Container(
                  child: Stack(
                    children: const <Widget>[
                      Center(
                        child: Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                        /*child: Image.asset(
                            'assets/images/manage/guanli_ON.png',
                            width: 22, height: 22,
                        ),*/
                      ),
                    ],
                  ),
                ),
                onPressed: () => MyNavigator.push(BuyerAccountInfo()),
              ),
            ),
          ],
        ),
      );
    });
  }

  /// My functional
  Widget _buildFunc(BuildContext context) {
    return Consumer<MyManageModel>(builder: (context, model, child) {
      return Container(
        height: 150,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 170, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: const LeftTitle(
                title: 'My Function',
              ),
            ),
            const MyDivider(),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => MyNavigator.push(OrderPage()),
                        child: const Icon(
                          Icons.assignment,
                          color: Color(0xFF4A4A4A),
                          size: 28,
                        ),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        backgroundColor: Colors.white,
                        splashColor: AppColors.primaryColor,
                        mini: true,
                      ),
                      const Text(
                        'Order',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 12),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => MyNavigator.push(AddressBuyer()),
                        child: const Icon(
                          Icons.location_city,
                          color: Color(0xFF4A4A4A),
                          size: 28,
                        ),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        backgroundColor: Colors.white,
                        splashColor: AppColors.primaryColor,
                        mini: true,
                      ),
                      const Text(
                        'Address',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 12),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.payment,
                          color: Color(0xFF4A4A4A),
                          size: 28,
                        ),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        backgroundColor: Colors.white,
                        splashColor: AppColors.primaryColor,
                        mini: true,
                      ),
                      const Text(
                        'PayWay',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 12),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () async {
                          // logout
                          await model.logout();
                          MyNavigator.pushAndRemove(InitialPage());
                        },
                        child: const Icon(
                          Icons.logout,
                          color: Color(0xFF4A4A4A),
                          size: 28,
                        ),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        backgroundColor: Colors.white,
                        splashColor: AppColors.primaryColor,
                        mini: true,
                      ),
                      const Text(
                        'Logout',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// more functional
  Widget _buildMoreFunc(BuildContext context) {
    return Consumer<MyManageModel>(builder: (context, model, child) {
        return Container(
          height: 250,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 340,
              left: 10,
              right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child: const LeftTitle(
                  title: 'More Function',
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () async {
                            // add crops
                            MyNavigator.push(AddCropPage());
                          },
                          child: const Icon(
                            Icons.add_business,
                            color: Color(0xFF4A4A4A),
                            size: 28,
                          ),
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          backgroundColor: Colors.white,
                          splashColor: AppColors.primaryColor,
                          mini: true,
                        ),
                        const Text(
                          'Add Crops',
                          style: TextStyle(
                              color: AppColors.primaryText, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Test icons
  Widget _buildIconItem(
      IconData iconData, String title, Color iconColor, Color textColor) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          color: iconColor,
          size: 28,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: textColor, fontSize: 12),
        )
      ],
    );
  }
}
