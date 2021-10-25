import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/cart/components/cart_list_page.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:crop_sales_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:crop_sales_app/screen/search/store/search_provider.dart';
import 'package:crop_sales_app/styles/colors.dart';

class SearchPage extends StatelessWidget {
  final String title;
  final String keyword;
  const SearchPage({Key? key, required this.title, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchPageProvider(),
      child: BaseScaffold(
        leadType: AppBarBackType.Back,
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/images/home/gouwuche.png',
              width: duSetWidth(25),
              height: duSetHeight(23.5),
            ),
            onPressed: () => MyNavigator.push(CartListPage()),
          ),
        ],
        title: title,
        body: SerachContainer(keyword: keyword),
      ),
    );
  }
}

class SerachContainer extends StatefulWidget {
  final String keyword;
  const SerachContainer({Key? key, required this.keyword}) : super(key: key);

  @override
  _SerachContainerState createState() => _SerachContainerState();
}

class _SerachContainerState extends State<SerachContainer> {
  String keyWord = '';
  @override
  void initState() {
    keyWord = widget.keyword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SearchPageProvider>(context);
    return Container(
      color: AppColors.primaryBackground,
      child: Column(
        children: <Widget>[
          SearchBar(
            keyword: keyWord,
            myOntap: (value) {
              setState(() {
                keyWord = value;
              });
              state.searchData(keyword: value);
            },
          ),
          Expanded(
            child: //state.loading
                //? MyLoadingWidget()
                //:
            Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    child: SmartRefresher(
                      enablePullUp: true,
                      controller: state.refreshController,
                      onRefresh: () => state.searchData(refresh: true, keyword: ''),
                      //onLoading: () => state.loadData,
                      header: WaterDropHeader(),
                      footer: MyCustomFooter(),
                      //child: ,//输出搜索结果
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
