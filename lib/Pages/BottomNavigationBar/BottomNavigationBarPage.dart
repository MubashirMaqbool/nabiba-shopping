import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/CartPage.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/CategoryPage.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/ContactUs.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/HomePage.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/LikedProductsPage.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/OrderHistory.dart';
import 'package:nabiba_app/Providers/CartBlock.dart';
import 'package:nabiba_app/Services/CartSqliteServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/customImagesIconsLink.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/stringWithStyle.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int currentIndex = 0;
  CartBlock cartBlock;
  CartSqliteServices _cartSqliteServices=CartSqliteServices();
  GlobalKey<ScaffoldState> scaffoldkey=GlobalKey<ScaffoldState>();

  List<Widget> bottomBarWidgets = List<Widget>();
  @override
  void initState() {
    bottomBarWidgets.add(HomePage());
   bottomBarWidgets.add(CategoryPage(scf_key: scaffoldkey));
   bottomBarWidgets.add(LikedProductsPage());
   bottomBarWidgets.add(ContactUs());
   bottomBarWidgets.add(OrderHistoryPage());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
      CustomColors.whiteColor, //or set color with: Color(0xFF0000FF)
    ));
    cartBlock=Provider.of<CartBlock>(context);
   _cartSqliteServices.countItemsInCart(cartBlock);
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.whiteColor,
          bottomNavigationBar: Card(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),),
            child: BottomNavigationBar(
                unselectedLabelStyle:  StringWithStyle.bottomBarLabelStyle,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: CustomColors.whiteColor,
                elevation: 10,
                backgroundColor: CustomColors.blueColor.withOpacity(0.9),
                selectedLabelStyle: StringWithStyle.bottomBarLabelStyle,
                unselectedItemColor: CustomColors.blackColor,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items:<BottomNavigationBarItem> [
                  BottomNavigationBarItem(
                      icon:Icon(ImagesIconsLink.homeIcon),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon:Icon(ImagesIconsLink.categoryIcon),
                      label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(ImagesIconsLink.heartIconOuline),
                      label: "Favourite"),
                  BottomNavigationBarItem(
                      icon:Icon(ImagesIconsLink.contacticon),
                      label: "Contact Us"),
                  BottomNavigationBarItem(
                      icon: Icon(ImagesIconsLink.OrdercartIcon),
                      label: "Your Orders"),

                ]),
          ),
          body: Column(
            children: [
              customAppBar(),
              Expanded(child: IndexedStack(index: currentIndex, children: bottomBarWidgets)),
            ],
          )),
    );
  }
  Widget cartBadge(){
    return InkWell(
      onTap: (){
        Navigator.push(context,  PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500),
            child: CartPage()));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8,top: 4),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: [
           Icon(ImagesIconsLink.cartIcon,color: CustomColors.blueColor,),
            Positioned(
                top: -ScreenSizeInfo.heightInfo*2.5,
                 left: -1,
                 child: Center(child: Container(
                   width: ScreenSizeInfo.heightInfo*2.5,
                   height: ScreenSizeInfo.heightInfo*2.5,
                   padding: EdgeInsets.all(2),
                     decoration: BoxDecoration(color: CustomColors.blueColor,borderRadius: BorderRadius.circular(30)),
                     child: Center(child: cartBlock.totalProducts >0 ? Text("${cartBlock.totalProducts}",style: StringWithStyle.cartTitleStyle,):Center(child: Text("0",style: StringWithStyle.cartTitleStyle,)))))),
          ],
        ),
      ),
    );
  }
  Widget customAppBar(){
    return Container(
      margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //appLogo(),
          nameLogo(),
          cartBadge(),

        ],
      ),
    );
  }
  Widget nameLogo(){
    return Container(
        height: ScreenSizeInfo.heightInfo*15,
        width: MediaQuery.of(context).size.width/1.5,
        child:Image.asset("assets/appnamelogo.png",fit: BoxFit.contain,));
  }
  Widget appLogo(){
    return Container(
        height: ScreenSizeInfo.heightInfo*15,
        width: ScreenSizeInfo.heightInfo*15,
        child:Image.asset("assets/logo2.png",width: 10,height: 10,fit: BoxFit.contain,));
  }

}
