import 'package:flutter/material.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';

class StringWithStyle {
  //..........String.............//
  static var appName = "NABIBA";

  //.............String Styles ..............//
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff21c2f0), Color(0xff1165ae)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static var appNameStyle = TextStyle(
      fontFamily: "fontStyle1",
      fontSize: ScreenSizeInfo.heightInfo * 3.5,
      fontWeight: FontWeight.bold,
      color: CustomColors.whiteColor);
  static var commonStyle = TextStyle(
      color: CustomColors.darkBlueColor,
      fontFamily: "fontStyle1",
      fontSize: ScreenSizeInfo.heightInfo * 3);
  static var commonButtonStringStyle = TextStyle(
      color: CustomColors.whiteColor,
      fontFamily: "fontStyle1",
      fontSize: ScreenSizeInfo.heightInfo * 2);
  static var bottomBarLabelStyle = TextStyle(
      color: CustomColors.blackColor,fontFamily: "fontStyle3",fontSize: 10);
  static var bottomBarAppBarLabelStyle =
  TextStyle(color: CustomColors.whiteColor, fontFamily: "fontStyle3");
static var productTextStyle=TextStyle(fontFamily: "fontStyle3",fontSize: 12,fontWeight: FontWeight.bold,color: CustomColors.blueColor);
  //.................. HOME PAGE TEXT WITH DESIGN .......... //

  static var myStory = "Very young I spent lonely moments in my room. during my worst hours, I dreamed without closing my eyes. I always saw myself in the future with my happy family in a house decorated in a way that I had never seen before. I thought it was going to be my world. today through my surreal works you can discover the complicated idea that was behind it all.I had no one to talk about the things that made my heart ache. in my memory hid my dream, without really knowing that one day I could through art, deposit my thoughts and transform my ideas into concrete thingsI say thank you to God, for always being there for me even when I didn't know it. And today, I am moved to tell you that the unhappy dreamer of yesterday turns into a surrealist. I am happy to share with you my works.you who dream like I did, wake up !!! it is the hour of concretization and contemplation. come admire my works and make yourself owners. beautify your home, bring more charms to your beauty. Nabiba, the art of elegance !!!";
  static var myStoryStyle = TextStyle(fontFamily: "fontStyle3", fontSize: 16);
  static var categoryTitleStyle = TextStyle(fontFamily: "fontStyle3", fontSize: 16,fontWeight: FontWeight.bold);
  static var cartTitleStyle=TextStyle(fontSize: 10,color: CustomColors.whiteColor,fontWeight: FontWeight.bold);

}