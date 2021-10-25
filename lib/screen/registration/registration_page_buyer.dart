import 'package:crop_sales_app/components/bottom_button.dart';
import 'package:crop_sales_app/components/my_loading.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/Registration/components/registration_model_buyer.dart';
import 'package:crop_sales_app/screen/login/buyer_login_page.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyerRegisterPage extends StatefulWidget {
  const BuyerRegisterPage({Key? key}) : super(key: key);

  @override
  State<BuyerRegisterPage> createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  bool pwdToogle = false;
  bool changeState = false;
  bool changeSave = false;
  final _formKey = GlobalKey<FormState>();

  void siginup(BuildContext context, model) async {
    model.startLoading();
    try {
      await model.signUp();
      Navigator.of(context).pop();
    } catch (e) {
      final snackBar = SnackBar(
        backgroundColor: AppColors.primaryBackground,
        content: Text(e.toString()),
      );
      MyToast.show(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      model.endLoading();
    }
  }

  void moveToHistory(BuildContext context) async {
    setState(() {
      changeState = true;
    });
    await Future.delayed(Duration(seconds: 1));
    await MyNavigator.pop();
    setState(() {
      changeState = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuyerRegisterModel>(
      create: (_) => BuyerRegisterModel(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => MyNavigator.pop(context: context),
          ), // leadin
        ),
        body: Center(
          child: SingleChildScrollView(
            //reverse: true,
            //padding: EdgeInsets.all(32),
            child: Consumer<BuyerRegisterModel>(builder: (context, model, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 30.0),
                          child: Column(
                            children: [
                              Text(
                                'Buyer registration',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // User name
                              TextFormField(
                                controller: model.nameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(245, 247, 247, 1),
                                  hintText: "Full Name",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                                // test ID
                                validator: (v) {
                                  String t = v ?? '';
                                  return t.trim().length > 0
                                      ? null
                                      : "Username can not be empty!"; //not be empty
                                },
                                onChanged: (text) {
                                  model.setName(text);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // User Tel
                              TextFormField(
                                controller: model.TelController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(245, 247, 247, 1),
                                  hintText: "Phone Number",
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Tel No cannot be blank.";
                                  } else if (value.length < 10) {
                                    return "Tel No length should be atleast 10.";
                                  }
                                },
                                onChanged: (text) {
                                  model.setTel(text);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // User address
                              TextFormField(
                                controller: model.addressController,
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(245, 247, 247, 1),
                                  hintText: "Address",
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Tel No cannot be blank.";
                                  }
                                },
                                onChanged: (text) {
                                  model.setAddress(text);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // User city
                              TextFormField(
                                controller: model.cityController,
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(245, 247, 247, 1),
                                  hintText: "City",
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Tel No cannot be blank.";
                                  }
                                },
                                onChanged: (text) {
                                  model.setCity(text);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // User email
                              TextFormField(
                                controller: model.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(245, 247, 247, 1),
                                  hintText: "Email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                                onChanged: (text) {
                                  model.setEmail(text);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // user password
                              TextFormField(
                                controller: model.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () => {
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
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
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
                                // test ID
                                validator: (v) {
                                  String t = v ?? '';
                                  return t.trim().length > 5
                                      ? null
                                      : "The password cannot be less than 6 digits."; //密码不能少于6位
                                },
                                onChanged: (text) {
                                  model.setPassword(text);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: MyButton(
                                  text: 'Buyer registration',
                                  handleOk: () => siginup(context, model),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (model.isLoading)
                    Center(
                        child: LoadingDialog(),
                    )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
