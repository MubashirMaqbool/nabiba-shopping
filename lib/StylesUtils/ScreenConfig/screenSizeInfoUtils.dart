import 'package:flutter/material.dart';


class ScreenSizeInfo{
  double _screenWidth;
  double _screenHieght;
  static double heightInfo=0;
  static double widthInfo=0;

  void getSizeInfo(BoxConstraints boxConstraints){
    _screenWidth=boxConstraints.maxWidth;
    _screenHieght=boxConstraints.maxHeight;

    widthInfo=_screenWidth/100;
    heightInfo=_screenHieght/100;
    print("Height==> $heightInfo");
    print("Width==> $widthInfo");
  }
}
