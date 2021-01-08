import 'package:flutter/material.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
class MyIconSpinner extends StatefulWidget {
  @override
  _MyIconSpinnerState createState() => _MyIconSpinnerState();
}

class _MyIconSpinnerState extends State<MyIconSpinner>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _controller.addListener((){
      if(_controller.isCompleted){
        _controller.repeat();
      }
    });

    super.initState();
  }
@override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Container(
        width: ScreenSizeInfo.heightInfo*15,
        height: ScreenSizeInfo.heightInfo*15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/logo2.png')
          ),
        ),
      )

    );
  }
}