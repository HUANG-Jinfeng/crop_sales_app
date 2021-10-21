// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:crop_sales_app/styles/colors.dart';
import 'package:crop_sales_app/utils/my_navigator.dart';
import 'package:crop_sales_app/utils/routers.dart';
//import 'package:crop_app/utilis/routers.dart';
import 'package:flutter/material.dart';

import 'manage_add_address.dart';

class AddressBuyer extends StatefulWidget {
  const AddressBuyer({Key? key}) : super(key: key);

  @override
  State<AddressBuyer> createState() => _AddressBuyerState();
}

class _AddressBuyerState extends State<AddressBuyer> {
  @override
  Widget build(BuildContext context) {
    bool addNewAddress = false;
    bool editAddress = false;
    bool removeAddress = false;
    bool goHome = false;

    movetoHome(BuildContext context) async {
      setState(() {
        goHome = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoute.homeRoute);
      setState(() {
        goHome = false;
      });
    }

    movetoNewaddress(BuildContext context) async {
      setState(() {
        addNewAddress = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await MyNavigator.push(AddAddress());
      setState(() {
        addNewAddress = false;
      });
    }

    movetoChangeaddress(BuildContext context) async {
      setState(() {
        editAddress = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoute.historyRoute);
      setState(() {
        editAddress = false;
      });
    }

    movetoRemoveaddress(BuildContext context) async {
      setState(() {
        removeAddress = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoute.historyRoute);
      setState(() {
        removeAddress = false;
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
                alignment: Alignment.topLeft,
                width: 600,
                color: Colors.white,
                child: Material(
                  borderRadius: BorderRadius.circular(addNewAddress ? 50 : 8),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => movetoNewaddress(context),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 40,
                      width: addNewAddress ? 50 : 200,
                      alignment: Alignment.center,
                      child: editAddress
                          ? Icon(Icons.done)
                          : Text(
                        "+ ADD NEW ADDRESS",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.topLeft,
                child: Text(
                  "DELIVERY ADDRESS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                color: Colors.white,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Usename",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Material(
                            borderRadius:
                            BorderRadius.circular(goHome ? 50 : 9),
                            color: Colors.grey[200],
                            child: InkWell(
                              onTap: () => movetoHome(context),
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                height: 20,
                                width: goHome ? 20 : 50,
                                alignment: Alignment.center,
                                child: editAddress
                                    ? Icon(Icons.done)
                                    : Text(
                                  "Home",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 500,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      color: Colors.white,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Address line 1",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 500,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      color: Colors.white,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Address line 2",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 500,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      color: Colors.white,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "City - xxxxxxx",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 500,
                height: 45,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      color: Colors.white,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "City",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      color: Colors.white,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Mobile: xxxxxxxxxx",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                color: Colors.white,
                child: Column(
                  children: [
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Material(
                              borderRadius:
                              BorderRadius.circular(editAddress ? 50 : 0),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => movetoChangeaddress(context),
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  height: 26,
                                  width: editAddress ? 50 : 310,
                                  alignment: Alignment.center,
                                  child: editAddress
                                      ? Icon(Icons.done)
                                      : Text(
                                    "EDIT",
                                    textAlign: TextAlign.center,
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
                        Container(
                          color: Colors.white,
                          height: 40,
                          width: 2,
                          child: VerticalDivider(color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Material(
                              borderRadius:
                              BorderRadius.circular(removeAddress ? 50 : 0),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => movetoRemoveaddress(context),
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  height: 26,
                                  width: removeAddress ? 50 : 310,
                                  alignment: Alignment.center,
                                  child: removeAddress
                                      ? Icon(Icons.done)
                                      : Text(
                                    "REMOVE",
                                    textAlign: TextAlign.center,
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
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
