import 'dart:io';

import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/crops/crops_list_page.dart';
import 'package:crop_sales_app/screen/home/components/crops_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:crop_sales_app/model/goods.dart';
import 'package:crop_sales_app/screen/home/components/brand_swiper.dart';
import 'package:crop_sales_app/screen/home/components/commodity_category.dart';
import 'package:crop_sales_app/screen/home/components/head_swiper.dart';
import 'package:crop_sales_app/screen/home/store/home_page_provider.dart';
import 'package:crop_sales_app/screen/main/components/preload_images.dart';
import 'package:crop_sales_app/screen/search/search_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';

import 'components/crops_dispplay_order.dart';
import 'components/crops_table_list.dart';

class BuyerHomePage extends StatefulWidget {
  const BuyerHomePage({Key? key}) : super(key: key);

  @override
  _BuyerHomePageState createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<BuyerHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => HomePageProvider(),

      child: BaseScaffold(
        leadType: AppBarBackType.None,
        actions: <Widget>[AppBarShopCartIconButton()],
        title: 'Home',
        centerTitle: true,
        body: HomePageContainer(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//old
class HomePageContainer extends StatefulWidget {
  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.primaryBackground,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        /*child: SmartRefresher(
                controller: state.refreshController,
                enablePullUp: true,
                //onRefresh: () => state.initData(refresh: false),
                //onLoading: state.loadData,
                header: WaterDropMaterialHeader(),
                footer: MyCustomFooter(),*/
        child: CustomScrollView(
          slivers: <Widget>[
            /// SearchBar
            SliverToBoxAdapter(
              child: SearchBar(
                  myOntap: (value) => MyNavigator.push(
                      SearchPage(title: 'Search', keyword: value))),
            ),

            /// CropsSelect
            CropsSelectPage(),

            /// CropsTableList
            /*CropsListPage(
                      title: 'Crops List',
                    ),*/

            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 44,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: LeftTitle(
                      tipColor: AppColors.primaryColor,
                      title: 'Crops List',
                    ),
                  ),
                  Container(
                    height: size.height - kNavigationBarHeight - 50 - 44 - 44 - 30 - 44 - 49,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    padding: EdgeInsets.only(bottom: 10),
                    child: CropListPage(),
                  ),
                ],
              ),
            ),

            /// anther
            /*SliverToBoxAdapter(
                      child: Container(
                        height: 44,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: LeftTitle(
                          tipColor: AppColors.primaryColor,
                          title: 'Crops List',
                        ),
                      ),
                    ),*/
          ],
        ),
      ),
    );
  }
}
