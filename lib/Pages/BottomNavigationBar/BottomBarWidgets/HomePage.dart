import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nabiba_app/Models/HomeSliderInfo.dart';
import 'package:nabiba_app/ReuseableWidgets/Animations/ShowUp.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int currenrPage=0;
  List<HomeSliderInfo> sliderInfo=[
    HomeSliderInfo(title: "Free home delivery",desc: "Provide free home delivery for all product over \$100",icon: "assets/homedelivery.png"),
    HomeSliderInfo(title: "Quality Products",desc: "We ensure the product quality that is our main goal",icon: "assets/qualityproducts.png"),
    HomeSliderInfo(title: "3 Days Return",desc: "Return product within 3 days for any product you buy",icon: "assets/return.png"),
    HomeSliderInfo(title: "Online Support",desc: "We ensure the product quality that you can trust easily",icon: "assets/onlineSupport.png"),

  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              sliderWithInfo(),
              indicators(),
              SizedBox(height: ScreenSizeInfo.heightInfo,),
              Center(child: Text("My Story",style: TextStyle(fontFamily: 'fontStyle3',fontSize: 20,fontWeight: FontWeight.bold,color: CustomColors.blueColor),textAlign: TextAlign.center,)),
              myStory(),
            ],
          ),
        ));
  }

  Widget sliderWithInfo(){
    return CarouselSlider.builder(
        itemCount: sliderInfo.length, itemBuilder: (context,index){
          return
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("${sliderInfo[index].icon}"),fit: BoxFit.cover
                    ),
                   // border: Border.all(color: CustomColors.blackColor,width: 0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                 // margin: EdgeInsets.all(5),
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text("${sliderInfo[index].title}",style: TextStyle(fontFamily: 'fontStyle3',color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                     // Text("${sliderInfo[index].desc}",style: TextStyle(fontFamily: 'fontStyle3',color: Colors.blueAccent),)
                    ],
                  ),
          ),
              );
    }, options: CarouselOptions(
     // enlargeCenterPage: true,
      initialPage: currenrPage,
      viewportFraction: 1.0,
      autoPlay: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index, reason) {
        setState(() {
          currenrPage=index;
        });
      },
    ));
  }

 Widget indicators(){
   return
     Container(
       margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
       child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             for(int a=0;a< sliderInfo.length;a++)
               a==currenrPage ? circleBar(true):circleBar(false)
           ]
       ),
     );
 }
 Widget circleBar(bool isActive) {
   return AnimatedContainer(
     duration: Duration(milliseconds: 200),
     margin: EdgeInsets.all(4),
     height: isActive ? 10 : 8,
     width: isActive ? 10 : 8,
     decoration: BoxDecoration(
       border: Border.all(color: isActive ?   CustomColors.blueColor : CustomColors.blueColor),
       borderRadius: BorderRadius.all(Radius.circular(10)),
       color: isActive ? CustomColors.blueColor : CustomColors.whiteColor,),

   );
 }
 Widget myStory(){
    return Container(
      margin: EdgeInsets.all(5),
      child: ShowUp(
        delay: 2000,
        child: Text("Very young I spent lonely moments in my room. During my worst hours, I dreamed without closing my eyes. I always saw myself in the future with my happy family in a house decorated in a way that I had never seen before. I thought it was going to be my world. Today through my surreal works you can discover the complicated idea that was behind it all. I had no one to talk about the things that made my heart ache. In my memory hid my dream, without really knowing that one day I could through art, deposit my thoughts and transform my ideas into concrete things I say thank you to God, for always being there for me even when I didn't know it. And today, I am moved to tell you that the unhappy dreamer of yesterday turns into a surrealist. I am happy to share with you my works. You who dream like I did, wake up !!! It is the hour of concretization and contemplation. Come admire my works and make yourself owners. Beautify your home, bring more charms to your beauty. Nabiba, the art of elegance !!!",
          style:TextStyle(fontFamily: 'fontStyle3'),textAlign: TextAlign.justify ,),
      ),
    );
 }
}

