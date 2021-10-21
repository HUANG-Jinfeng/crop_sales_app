import 'package:crop_sales_app/components/components.dart';
import 'package:crop_sales_app/screen/Registration/registration_page_seller.dart';
import 'package:crop_sales_app/screen/main/main_page_seller.dart';
import 'package:crop_sales_app/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerLoginPage extends StatefulWidget {
  SellerLoginPage({Key? key}) : super(key: key);

  @override
  _SellerLoginFormState createState() => _SellerLoginFormState();
}

class _SellerLoginFormState extends State<SellerLoginPage> {
  bool pwdToogle = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  String? email;
  String? password;
  bool isLoading = false;

  void _removeEmail() {_unameController.clear();}

  void _removePassword() {_pwdController.clear();}

  @override
  void initState() {super.initState();}

  @override
  void dispose() {super.dispose();}

  Future loginAction(BuildContext context) async {
    email = _unameController.text;
    password = _pwdController.text;

    try {
      if (email != null && password != null) {
        // Login OK
        Navigator.push(context, DialogRouter(LoadingDialog()));
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        if ((_formKey.currentState as FormState).validate()) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SellerMainPage(),
            ),
          );
          MyToast.show('Login successfully!');
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SellerRegisterPage(),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
    }
  }

  @override
  Widget build(BuildContext context) {
    _unameController.addListener(() {
      setState(() {});
    });
    _pwdController.addListener(() {
      setState(() {});
    });
    return BaseScaffold(
      appBar: MyAppBar(
        leadingType: AppBarBackType.None,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        //reverse: true,
        //padding: EdgeInsets.all(10),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            padding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/login/login_seller.png"),
                          //width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'Welcome Seller',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: _unameController,
                    onSaved: (value) {
                      if (value!.isEmpty) {
                        _unameController.text = value;
                      }
                      _unameController.text = "";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => _removeEmail(),
                        child: _unameController.text != ''
                            ? Icon(
                          Icons.cancel,
                          size: 18,
                          color: AppColors.primaryColor,
                        )
                            : SizedBox(),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromRGBO(245, 247, 247, 1),
                      hintText: "ID / Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.primaryGreyText1,
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      String t = value ?? '';
                      return t
                          .trim()
                          .length > 0
                          ? null
                          : "Username can not be empty!"; //用户名不能为空
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _pwdController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _pwdController.text != ''
                              ? GestureDetector(
                              onTap: () => _removePassword(),
                              child: Icon(
                                Icons.cancel,
                                size: 18,
                                color: AppColors.primaryColor,
                              ))
                              : SizedBox(),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () =>
                            {
                              setState(() {
                                pwdToogle = !pwdToogle;
                              })
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromRGBO(245, 247, 247, 1),
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.password,
                        color: AppColors.primaryGreyText1,
                      ),
                    ),
                    obscureText: !pwdToogle,
                    cursorColor: AppColors.primaryColor,
                    //Test password
                    validator: (v) {
                      String t = v ?? '';
                      return t
                          .trim()
                          .length > 5
                          ? null
                          : "The password cannot be less than 6 digits."; //
                    },
                    onSaved: (value) {
                      if (value!.isEmpty) {
                        _pwdController.text = value;
                      }
                      _pwdController.text = "";
                    },
                  ),
                  // Login button
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: MyButton(
                      text: 'Seller Login',
                      handleOk: () => loginAction(context),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => {},
                        child: Text(
                          'Forgot for password?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(155, 155, 155, 1),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      SizedBox(
                        width: 1,
                        height: 14,
                        child: const DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(217, 217, 217, 1)),
                        ),
                      ),
                      SizedBox(width: 14),
                      GestureDetector(
                        onTap: () => {},
                        child: TextButton(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(18, 18, 18, 1),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                //RegistrationPage()
                                SellerRegisterPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(height: 60,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}