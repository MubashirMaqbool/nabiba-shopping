import 'package:flutter/material.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';

class SnackBarWidget {
  static snackBar(GlobalKey<ScaffoldState> scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      elevation: 10,
      content: Text(
        '$text',
        style: TextStyle(color: CustomColors.blueColor),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: CustomColors.greenColorlight,
    ));
  }
}
