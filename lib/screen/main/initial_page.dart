import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/login/buyer_login_page.dart';
import 'package:crop_sales_app/screen/login/seller_login_page.dart';
import 'package:crop_sales_app/screen/main/main_page_buyer.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialFormState createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

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
          height: MediaQuery.of(context).size.height,
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
                      mainAxisAlignment: MainAxisAlignment.center, children: const [
                    Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: 130,
                      height: 130,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Long Term Industrial Development',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: MyButton(
                    text: 'Seller Login',
                    handleOk: () => _LoginPage(context, 1),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: MyButton(
                    text: 'Buyer Login',
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
