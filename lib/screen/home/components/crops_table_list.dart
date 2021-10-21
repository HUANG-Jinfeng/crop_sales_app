import 'package:crop_sales_app/components/left_title.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'crops_class.dart';

class CropsListPage extends StatefulWidget {
  CropsListPage({required this.title}) : super();
  final String title;

  @override
  _CropsListPageState createState() => _CropsListPageState();
}

class _CropsListPageState extends State<CropsListPage> {
  //刷新的时候都要给个controller
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  //其实这里也有多次触发加载的问题，所以博主用这个参数来解决了
  bool isRefreshing = false;

  @override
  void initState() {
    //初始化数据
    user.initData(10);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
              )
          ),
          Container(
            height: 400,
            color: Colors.white,
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: _getBodyWidget(),
            //child: CropsTablePage(),
            //child: CropsTableDemo(),
          ),
        ],
      ),
    );
  }

  Widget _getBodyWidget() {
    ///这段代码上面介绍过
    return HorizontalDataTable(
      leftHandSideColumnWidth: 30,
      rightHandSideColumnWidth: 500,
      isFixedHeader: true,
      elevation: 0.5,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: user.userInfo.length,
      rowSeparatorWidget: const Divider(
        color: Color(0xFFEFEFEF),
        height: 0.5,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: Colors.white,
      rightHandSideColBackgroundColor: Colors.white,
      verticalScrollbarStyle: const ScrollbarStyle(
        isAlwaysShown: false,
        thickness: 1.0,
        radius: Radius.circular(5.0),
      ),
      horizontalScrollbarStyle: const ScrollbarStyle(
        isAlwaysShown: false,
        thickness: 1.0,
        radius: Radius.circular(5.0),
      ),
      enablePullToRefresh: true,
      refreshIndicator: const WaterDropHeader(),
      refreshIndicatorHeight: 60,
      onRefresh: () async {
        //Do sth
        await Future.delayed(const Duration(milliseconds: 500));
        _hdtRefreshController.refreshCompleted();
      },
      htdRefreshController: _hdtRefreshController,
    );
  }

  ///准备表头的widget
  List<Widget> _getTitleWidget() {
    return [
      Container(
        child: _getTitleItemWidget('No.', 55),
      ),
      Container(
        child: _getTitleItemWidget('Crops', 80),
      ),
      _getTitleItemWidget('Price', 80), //
      _getTitleItemWidget('Register', 80),  //date
      _getTitleItemWidget('Kg', 80),  //
      _getTitleItemWidget('count', 80), //
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: Color(0xFF848B97))),
      width: width,
      color: Color(0xFFF5F5F5),
      height: 32,
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  ///左侧序号的widget实现，是类似代理的方法，提供了context和index，方便我们自己做更多的扩展
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      child: Text(user.userInfo[index].number,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: Color(0xFF1C2026))),
      width: 55,
      height: 38,
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  ///右侧序号的widget实现，是类似代理的方法，提供了context和index，方便我们自己做更多的扩展
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    //加载的方法
    if (index == user.userInfo.length - 1 && isRefreshing == false) {
      isRefreshing = true;
      Future.delayed(Duration.zero).then((value) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 98.0,
                      color: Colors.white,
                      width: 98.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black))),
                ),
              );
            });
      });

      ///做了个模拟加载的延时操作
      Future.delayed(Duration(seconds: 2), () {}).then((onValue) {
        user.loadMore();
        print('request');
        //关闭加载弹窗，自己用的时候context一样要设全局，在需要的位置使用，否则很容易使用到当前页面的context，关闭整个页面，切记
        Navigator.of(context).pop();
        setState(() {
          ///加载数据完成后，变false，就不会再触发加载
          isRefreshing = false;
        });
      });
    }

    ///整行数据，可以再封装一下每一个widget，代码量能少百分之七八十，相信大家都会的
    return Row(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Text(user.userInfo[index].crop ? 'Tomato' : 'Potato',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFF1C2026))),
          width: 70,
          height: 38,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: Colors.white,
          child: Text(user.userInfo[index].price,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFF1C2026))),
          width: 80,
          height: 38,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: Colors.white,
          child: Text(user.userInfo[index].date,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFF1C2026))),
          width: 80,
          height: 38,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: Colors.white,
          child: Text(user.userInfo[index].kg,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFF1C2026))),
          width: 100,
          height: 38,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: Colors.white,
          child: Text('${(index + 1) * 100}',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFF1C2026))),
          width: 100,
          height: 38,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
