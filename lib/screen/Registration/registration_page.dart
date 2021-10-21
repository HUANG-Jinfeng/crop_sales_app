import 'package:crop_sales_app/components/bottom_button.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool changeState = false;
  bool changeSave = false;
  final _formKey = GlobalKey<FormState>();

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

  void Save(BuildContext context) async {
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

    return Scaffold(
      appBar: AppBar(
        //title: Text("Buyer Info"),
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () => moveToHistory(context),
        ), // leadin
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 130,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 105,
                          margin: EdgeInsets.zero,
                          child: Image.asset(
                            'assets/images/manage/pngegg.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('ID: 20210925300001', style: TextStyle(
                          color: AppColors.primaryGreyText, fontSize: 12)
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Buyer Info',
                    style: TextStyle(
                      color: AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.w600,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 50.0),
                          child: Column(
                            children: [
                              TextFormField(
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
                                  labelText: "ID",
                                  prefixIcon: Icon(
                                    Icons.person,color: AppColors.primaryGreyText1,
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
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
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
                                  labelText: "Full Nmae",
                                  prefixIcon: Icon(
                                    Icons.account_box,color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
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
                                  labelText: "Phone Number",
                                  prefixIcon: Icon(
                                    Icons.phone,color: AppColors.primaryGreyText1,
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
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
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
                                  labelText: "Email",
                                  prefixIcon: Icon(
                                    Icons.email,color: AppColors.primaryGreyText1,
                                  ),
                                ),
                                cursorColor: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Material(
                                borderRadius:
                                BorderRadius.circular(changeState ? 50 : 8),
                                color: Colors.transparent,
                                child: InkWell(
                                  //onTap: () => Save(context),
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    height: 40,
                                    width: changeState ? 50 : 200,
                                    alignment: Alignment.center,
                                    child: changeState
                                        ? Icon(Icons.done)
                                        : Text(
                                      "CHANGE PASSWORD",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: MyButton(
              text: 'SAVE DETAILS', //
              handleOk: () => Save(context),
            ),
          ),
          alignment: Alignment.center,
          /*child: Material(
            borderRadius: BorderRadius.circular(changeState ? 50 : 0),
            color: Colors.deepPurpleAccent[400],
            child: InkWell(
              //onTap: () => Save(context),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 35,
                width: changeState ? 50 : 310,
                alignment: Alignment.center,
                child: changeState
                    ? Icon(Icons.done)
                    : Text(
                  "SAVE DETAILS",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),*/
        ),
      ],
    );
  }
}

