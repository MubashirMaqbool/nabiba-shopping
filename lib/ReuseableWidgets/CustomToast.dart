import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';

class CustomToast{
  static showToast(String msg){
    Fluttertoast.showToast(
        msg:msg ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColors.greenColorlight,
        textColor: CustomColors.blueColor,
        fontSize: 16.0
    );
  }
}