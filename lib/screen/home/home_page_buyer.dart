import 'dart:io';
import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/crops/buyer_crops_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_sales_app/screen/home/store/home_page_provider.dart';
import 'package:crop_sales_app/screen/search/search_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'components/crops_dispplay_order.dart';

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

            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 44,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: LeftTitle(
                      tipColor: AppColors.primaryColor,
                      title: 'Crops List',
                    ),
                  ),
                  Container(
                    height: size.height - kNavigationBarHeight - 255,
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    //padding: EdgeInsets.only(bottom: 10),
                    child: BuyerCropListPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
