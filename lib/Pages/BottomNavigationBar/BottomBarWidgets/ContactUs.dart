import 'package:flutter/material.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/customImagesIconsLink.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

           contactUsLogo(),
        SizedBox(height: ScreenSizeInfo.heightInfo,),
        Center(child: Text("Link With Us Through",style: TextStyle(fontFamily: "fontStyle3",color: CustomColors.blueColor,fontWeight: FontWeight.bold),)),
        contactLogos(),
      ],
    );
  }
  Widget contactUsLogo(){
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenSizeInfo.heightInfo*40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            image: AssetImage('assets/contactUsLogo.jpg')
          )
        ),
      ),
    );
  }
  Widget contactLogos(){
    return Center(
      child: Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              InkWell(
                onTap: () async{
                  var whatsappUrl ="whatsapp://send?phone=+1 (917) 794-9248";
                   await launch(whatsappUrl);
                },
                  child: Icon(ImagesIconsLink.whatsapp,size: ScreenSizeInfo.heightInfo*6,color: Colors.green,)),
            SizedBox(width: ScreenSizeInfo.heightInfo,),
            InkWell(
              onTap: () async{
                var faceBookUrl ="https://web.facebook.com/nabiba01";
                await launch(faceBookUrl);
              },
                child: Icon(ImagesIconsLink.facebook_circled,size: ScreenSizeInfo.heightInfo*6,color: Colors.blue,)),
            SizedBox(width: ScreenSizeInfo.heightInfo,),
            InkWell(
                onTap: () async{
                  var faceBookUrl ="https://www.instagram.com//nabi.bastore";
                  await launch(faceBookUrl);
                },
                child: Icon(ImagesIconsLink.instagram_square,size: ScreenSizeInfo.heightInfo*6,color: Colors.redAccent,)),
          ],

        ),
      ),
    );
  }
}
