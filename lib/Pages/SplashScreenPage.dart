import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/customImagesIconsLink.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor:
      CustomColors.whiteColor,
    ));
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appLogo(),
            ],
          ),
          companyName(),
        ],
      ),
    ));
  }
  Widget companyName(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Powered By Marcom Planet",style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor,fontSize: 12),),
          Container(
            width: ScreenSizeInfo.heightInfo*8,
            height: ScreenSizeInfo.heightInfo*8,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/marcomlogo.png')
            )
          ),)
        ],
      ),
    );
  }

  Widget appLogo() {
    return Container(
      height: ScreenSizeInfo.heightInfo * 30,
      width: ScreenSizeInfo.heightInfo * 30,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagesIconsLink.appLogo), fit: BoxFit.contain)),
    );
  }

  startTimer() async {
    return Timer(
        Duration(seconds: 3),
        () => {
              Navigator.pushReplacement(context,
                  PageTransition(type: PageTransitionType.rightToLeftWithFade, duration: Duration(milliseconds: 500), child: BottomNavigationBarPage()))
            });
  }
}
