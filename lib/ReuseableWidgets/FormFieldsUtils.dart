import 'package:flutter/material.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';

class FormFieldUtils{

  static  setInputDecorations(dynamic labelText,dynamic icon) {
    return InputDecoration(
      labelText: "${labelText}",
      labelStyle: TextStyle(color: CustomColors.darkBlueColor),
      prefixIcon: Icon(icon, color: CustomColors.darkBlueColor,),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.darkBlueColor, width: 2.0)
      ),
    );
  }
  static  setRegionInputDecorations(dynamic labelText){
    return InputDecoration(
      labelText: "${labelText}",
      labelStyle: TextStyle(color: CustomColors.darkBlueColor,fontSize: 10),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(color: CustomColors.darkBlueColor, width: 2.0)
      ),
    );
  }
  static  ratingInputDecorations(dynamic labelText,dynamic icon) {
    return InputDecoration(
      labelText: "${labelText}",
      labelStyle: TextStyle(color: CustomColors.darkBlueColor,fontFamily: 'fontStyle3'),
      prefixIcon: Icon(icon, color: CustomColors.darkBlueColor,),
    );
  }

}