import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/stringWithStyle.dart';


class BottomSheetWidget{
  static showBottomBar(BuildContext context,dynamic images,dynamic text){
    showMaterialModalBottomSheet(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) => Container(
       // decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))),
        height: MediaQuery.of(context).size.height/2,
         child: Column(
           children: [
             Container(
               margin: EdgeInsets.all(ScreenSizeInfo.heightInfo*2),
               height: MediaQuery.of(context).size.height/2.5,
               decoration:BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                 image: DecorationImage(image: NetworkImage(images),fit: BoxFit.fill)
               ),
             ),
             Text(text,
               textAlign: TextAlign.center,style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.redColor),),
             Container(height: 2,width: MediaQuery.of(context).size.width-50,color: CustomColors.blueColor,)
           ],
         ),
      ),
    );
  }
}