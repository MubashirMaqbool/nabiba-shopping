import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';

class ImagesIconsLink {
  static var appLogo = "assets/logo.png";

  //...........Icons class Link..............//
  static const  contacticon = IconData(0xe830, fontFamily: 'Bottombaricons', fontPackage: null);
  static const  homeIcon = IconData(0xe801, fontFamily: 'Bottombaricons', fontPackage: null);
  static const  OrdercartIcon = IconData(0xf23d, fontFamily: 'Bottombaricons', fontPackage: null);
  static const  categoryIcon = IconData(0xe872, fontFamily: 'Bottombaricons', fontPackage: null);
  static var cartIcons = Icon(
    Icons.shopping_cart,
    color: CustomColors.blueColor,
    size: ScreenSizeInfo.heightInfo*4,
  );
  static  const heartIcon = IconData(0xe800, fontFamily: 'Hearticons', fontPackage: null);
  static  const heartIconOuline = IconData(0xe801, fontFamily: 'Hearticons', fontPackage: null);
  static const  cartIcon = IconData(0xe800, fontFamily: 'Carticon', fontPackage: null);
  static const  instagram_square = IconData(0xe800, fontFamily: "Socialicons", fontPackage: null);
  static const  whatsapp = IconData(0xf232, fontFamily: "Socialicons", fontPackage: null);
  static const  facebook_circled = IconData(0xf30d, fontFamily: "Socialicons", fontPackage: null);


}

