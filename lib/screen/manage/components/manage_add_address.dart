// ignore_for_file: prefer_const_constructors

import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:crop_sales_app/utils/routers.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool cancel = false;
    bool save = false;

    movetoCancel(BuildContext context) async {
      setState(() {
        cancel = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoute.addressRoute);
      setState(() {
        cancel = false;
      });
    }

    movetoSave(BuildContext context) async {
      setState(() {
        save = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoute.homeRoute);
      setState(() {
        save = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        //title: Text("Buyer Info"),
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () => MyNavigator.pop(),
        ), // leadin
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              SizedBox(
                height: 4,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 650,
                height: 25,
                color: Colors.white10,
                child: Text(
                  "ADD NEW ADDRESS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                width: 650,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name*",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFAFAFA),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username cannot be empty";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Mobile*",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xFFFAFAFA)),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              color: Colors.grey[50],
                              height: 10,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Pincode*",
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400]),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFFAFAFA)),
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "State*",
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400]),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFFAFAFA)),
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText:
                                "Address(House No, Building, Street, Area)*",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xFFFAFAFA)),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Locality/ Town*",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xFFFAFAFA)),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "City/ District*",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xFFFAFAFA)),
                                ),
                              ),
                              obscureText: true,
                            ),
                            Container(
                              color: Colors.white,
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[50],
                height: 30,
                width: 650,
              ),

            ],
          ),
        ),
      ),

      persistentFooterButtons: [
        Padding(padding: EdgeInsets.zero),

        Row(
          children: [
            Padding(padding: EdgeInsets.zero),
            Expanded(
              child: Container(
                height: 40,
                color: Colors.white,
                child: Material(
                  borderRadius: BorderRadius.circular(cancel ? 50 : 0),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => MyNavigator.pop(),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 35,
                      width: cancel ? 50 : 310,
                      alignment: Alignment.center,
                      child: cancel
                          ? Icon(Icons.done)
                          : Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                color: AppColors.primaryColor,
                child: Material(
                  borderRadius: BorderRadius.circular(save ? 50 : 0),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => movetoSave(context),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 35,
                      width: save ? 50 : 310,
                      alignment: Alignment.center,
                      child: save
                          ? Icon(Icons.done)
                          : Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
