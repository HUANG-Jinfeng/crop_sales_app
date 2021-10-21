import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/login/buyer_login_page.dart';
import 'package:crop_sales_app/screen/login/seller_login_page.dart';
import 'package:crop_sales_app/screen/main/main_page_buyer.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key? key}) : super(key: key);

  @override
  _InitialFormState createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialPage> {
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void _LoginPage(BuildContext context, choose) async {
    if (choose == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext ctx) => SellerLoginPage(),
        ),
      );
    } else if (choose == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext ctx) => BuyerLoginPage(),
          //builder: (BuildContext ctx) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: MyAppBar(
        leadingType: AppBarBackType.None,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.25,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Long Term Industrial Development',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 100,
                ),
                // 登录按钮
                /*Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: MyButton(
                    text: 'Seller Login', //元登录按键
                    handleOk: () => _LoginPage(context, 1),
                  ),
                ),*/
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: MyButton(
                    text: 'Buyer Login', //元登录按键
                    handleOk: () => _LoginPage(context, 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}