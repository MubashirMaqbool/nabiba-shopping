import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/PaymentIntegrationPages/UserInfoPage.dart';
import 'package:nabiba_app/Providers/CartBlock.dart';
import 'package:nabiba_app/ReuseableWidgets/SnakBarWidget.dart';
import 'package:nabiba_app/Services/CartSqliteServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/stringWithStyle.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBlock _cartBlock;
  CartSqliteServices cartSqliteServices=CartSqliteServices();
  GlobalKey<ScaffoldState> scaffoldkey=GlobalKey<ScaffoldState>();
  dynamic productQuantity=0;
  @override
  void initState() {
    CartBlock cartBlock=Provider.of<CartBlock>(context,listen: false);
    cartSqliteServices.getProductsInfoInCart(cartBlock);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _cartBlock=Provider.of<CartBlock>(context);
    cartSqliteServices.getTotalProductsPrice(_cartBlock);
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_outlined,color: CustomColors.blueColor,)),
        backgroundColor: CustomColors.whiteColor,
        title: Text("My Cart",style: TextStyle(fontFamily: "fontStyle3",color: CustomColors.blueColor),),
      ),
        body: Container(
          margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
          child: Column(
          children: [
         Expanded(child: cartProductInfo()),

            totalPrice(),
          ],
        ),));
  }
  Widget cartProductInfo(){
    return _cartBlock.productInfoList.length >0 ? ListView.builder(
      itemCount: _cartBlock.productInfoList.length,
        itemBuilder: (_,index){
      return Card(
        elevation: 10,
          child: Container(
        height: ScreenSizeInfo.heightInfo*17,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: [
                Center(child: CupertinoActivityIndicator()),
                Container(
                  margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
                  height: ScreenSizeInfo.heightInfo*10.5,
                  width: ScreenSizeInfo.heightInfo*10.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenSizeInfo.heightInfo),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                          image: NetworkImage(_cartBlock.productInfoList[index].product_image))),),

              ],
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text(_cartBlock.productInfoList[index].product_name,style: StringWithStyle.productTextStyle),),
                  Text("${_cartBlock.productInfoList[index].product_price*_cartBlock.productInfoList[index].product_quantity} \$ ",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "fontStyle2"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row( children: [
                        InkWell(
                          hoverColor: CustomColors.whiteColor,
                          onTap: () async{
                            CartModel cartModel=_cartBlock.productInfoList[index];
                            productQuantity=cartModel.product_quantity +1;
                            cartModel.product_quantity=productQuantity;
                            await cartSqliteServices.insertOrUpdateProductsInfo(cartModel, productQuantity,_cartBlock);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: CustomColors.blueColor),
                            child: Icon(Icons.add,color: CustomColors.whiteColor,),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("${_cartBlock.productInfoList[index].product_quantity}",style: StringWithStyle.productTextStyle,),
                        SizedBox(width: 10,),
                        InkWell(
                          hoverColor: CustomColors.whiteColor,
                          onTap: () async{
                            CartModel cartModel=_cartBlock.productInfoList[index];
                            productQuantity=cartModel.product_quantity -1;
                            if(productQuantity<=0){
                              SnackBarWidget.snackBar(scaffoldkey, "Product Quantity can not be Zer0 !");
                            }
                            else{
                              cartModel.product_quantity=productQuantity;
                              await cartSqliteServices.insertOrUpdateProductsInfo(cartModel, productQuantity,_cartBlock);
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: CustomColors.blueColor),
                            child: Icon(Icons.remove,color: CustomColors.whiteColor,),
                          ),
                        ),
                      ],),

                       IconButton(icon: Icon(Icons.delete,color: Colors.redAccent,), onPressed: () async{
                         await cartSqliteServices.delSpecificProduct(_cartBlock.productInfoList[index].product_id,_cartBlock);
                       })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ));
    }):_cartBlock.productInfoList.length==0  ? Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: ScreenSizeInfo.heightInfo*35,
          height: ScreenSizeInfo.heightInfo*40,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/emptyCart.png'))),),
        Text("Your Cart is Empty", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontFamily: 'fontStyle3',color: CustomColors.blueColor))
      ],
    ),):Center(child: CupertinoActivityIndicator());
  }


  Widget  totalPrice(){
    return _cartBlock.totalPrice !=null  ? Card(
      elevation: 10,
      color: CustomColors.blueColor,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        height: ScreenSizeInfo.heightInfo*8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Total : ",style: TextStyle(color: Colors.white,fontFamily: "fontStyle3"),),
                SizedBox(width: 10,),
                  Text("${_cartBlock.totalPrice.toStringAsFixed(2)}\$",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "fontStyle3",color: Colors.white)),


              ],
            ),
             Card(
               elevation: 10,
               child: InkWell(
                 onTap: () async{
                   Navigator.push(context,  PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500),
                       child: UserInfoPage(cartmodel: _cartBlock.productInfoList,total: _cartBlock.totalPrice,)));
                 },
                 hoverColor: Colors.black,
                 child: Container(
                     margin: EdgeInsets.all(4),
                     child: Center(child: Text("Checkout",style:
                     TextStyle(fontFamily: "fontStyle3",color: CustomColors.blueColor),))),
               ),
             )

          ],
        )),
    ):Container();
  }
}