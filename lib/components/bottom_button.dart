import 'package:crop_sales_app/styles/styles.dart';
import 'package:flutter/material.dart';

// MyButton
class MyButton extends StatelessWidget {
  final String? text;
  final Function? handleOk;
  final Function? pushPage;

  const MyButton({Key? key, this.handleOk, this.pushPage, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
        left: 10,
        right: 10,
      ),
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          //Color
          colors: [AppColors.buttonLine1, AppColors.buttonLine2],
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.transparent,
        splashColor: AppColors.primaryGreyText1,
        elevation: 0,
        highlightElevation: 0,
        onPressed: () => {handleOk!(),pushPage!(),},
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
