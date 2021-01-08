import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nabiba_app/ApiUtils/SingleProductsApiUtils.dart';
import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/Models/ProductsModel.dart';
import 'package:nabiba_app/Models/ReviewModel.dart';
import 'package:nabiba_app/Models/wisListModel.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/BottomBarWidgets/UserFeeedBackPage.dart';
import 'package:nabiba_app/Providers/CartBlock.dart';
import 'package:nabiba_app/Providers/SingleProductBlock.dart';
import 'package:nabiba_app/ReuseableWidgets/CustomLoadingBar.dart';
import 'package:nabiba_app/ReuseableWidgets/SnakBarWidget.dart';
import 'package:nabiba_app/Services/CartSqliteServices.dart';
import 'package:nabiba_app/Services/FirebaseServices/ReviewsServices.dart';
import 'package:nabiba_app/Services/LikedProductsServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:provider/provider.dart';

class SingleProductInfo extends StatefulWidget {
  String productId,image,title,catID,descirption;
  SingleProductInfo({this.title,this.productId,this.image,this.catID,this.descirption});
  @override
  _SingleProductInfoState createState() => _SingleProductInfoState();
}

class _SingleProductInfoState extends State<SingleProductInfo> {

  SingleProductApiUtils singleProductApiUtils=SingleProductApiUtils();
  CartSqliteServices cartSqliteServices=CartSqliteServices();
  GlobalKey<ScaffoldState> scaffoldkey=GlobalKey<ScaffoldState>();
  LikedProductsServices likedProductsServices;
  WishListModel wishListModel=WishListModel();
  SingleProductBlock _singleProductBlock;
  CartBlock cartBlock;
  Future<ProductsModel> producutsInfo;
  Future<List<ReviewModel>> reviewList;
  ReviewsServices _reviewsServices=ReviewsServices();
  int currentpage=0;
  int currentIndex=0;
  int len=0;

@override
  void dispose() {
  _singleProductBlock.singleProductInfo.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    SingleProductBlock _singleProductBlock=Provider.of<SingleProductBlock>(context,listen: false);
    singleProductApiUtils.singleProductInfoApiCalling(widget.productId, _singleProductBlock);
    producutsInfo=singleProductApiUtils.singleProductInfosApiCalling(widget.productId);
    reviewList=_reviewsServices.getProductReviews(widget.productId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _singleProductBlock=Provider.of<SingleProductBlock>(context);
    cartBlock=Provider.of<CartBlock>(context);
    likedProductsServices=Provider.of<LikedProductsServices>(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CustomColors.whiteColor,
          title: Text("NABIBA",style: TextStyle(fontFamily: "fontStyle3",color: CustomColors.blueColor,fontWeight: FontWeight.bold),),
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_outlined,color: CustomColors.blueColor,)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              imagesWithViewPager(),
              singleProductInfoData(),
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,height: 2,color: Colors.black12,),
             gettingProductReviews(widget.productId.toString()),
            ],
          ),
        ),
      ),
    );
  }
  Widget singleProductInfoData(){
    return _singleProductBlock.singleProductInfo.length >0 ?
    Container(
      margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenSizeInfo.heightInfo*2,),
        Stack(
          alignment: Alignment.centerRight,
          overflow: Overflow.visible,
          children: [
            Container(height: 2,width: MediaQuery.of(context).size.width,color: Colors.black12,),
            Positioned(
             // bottom: -5,right: 0,
                child: reviewAndComments()),
          ],
        ),
        SizedBox(height: ScreenSizeInfo.heightInfo*2,),
        Text("${widget.title}",style: TextStyle(color: CustomColors.blueColor,fontFamily: "fontStyle3",fontSize: 16,fontWeight: FontWeight.bold),),
       /* Row(
          children: [
            Text("Price :",style: TextStyle(fontFamily: 'fontStyle3'),),
            SizedBox(width: 10,),
            Text("${_singleProductBlock.singleProductInfo[0].price} \$",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "fontStyle3",fontSize: 20),),
            SizedBox(width: 20,),
            CalculateOldPrice(_singleProductBlock.singleProductInfo[0].price)
            // _singleProductBlock.singleProductInfo.asMap()[1] != null  ?
            //Text( '${_singleProductBlock.singleProductInfo[1].price} \$',style:TextStyle(fontWeight: FontWeight.bold,fontFamily: "fontStyle3",decoration: TextDecoration.lineThrough)):Container(),
          ],
        ),

        */
        Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,height: 2,color: Colors.black12,),
        Text("Select Product Information",style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor),),
        productSelectionInfo(),
        Row(
          children: [
            Expanded(child: RaisedButton(onPressed: () async{
              bool result=await cartSqliteServices.checkProductInCart(widget.productId);
              if(result){
                 SnackBarWidget.snackBar(scaffoldkey, "Product is Already in Cart Goto Cart To Update Info");
              }
              else{
                CartModel cartModel=CartModel();
                cartModel.product_id=widget.productId;
                cartModel.product_quantity=1;
                cartModel.product_price=_singleProductBlock.singleProductInfo[currentIndex].price;
                cartModel.product_name=widget.title;
                cartModel.product_image=widget.image;
                cartModel.variant_id=_singleProductBlock.singleProductInfo[currentIndex].variant_id;
                await  cartSqliteServices.insertOrUpdateProductsInfo(cartModel, 1,cartBlock);
                SnackBarWidget.snackBar(scaffoldkey, "Product Added To Cart Successfully");
              }
            },child:
            Text("Add To Cart",style: TextStyle(color: CustomColors.whiteColor),),elevation: 10,color: CustomColors.blueColor,),),
            SizedBox(width: 10,),
            Expanded(child: OutlineButton(onPressed: () async{

              if(await likedProductsServices.checkProductInWishList(widget.productId)){

                SnackBarWidget.snackBar(scaffoldkey, " Already Added to WishList");
              }
              else{
                wishListModel.product_id=widget.productId;
                wishListModel.product_name=widget.title;
                wishListModel.product_image=widget.image;
                wishListModel.product_quantity="1";
                wishListModel.product_price=_singleProductBlock.singleProductInfo[0].price.toString();
                wishListModel.catId=widget.catID;
                likedProductsServices.addToWishList(wishListModel);
                SnackBarWidget.snackBar(scaffoldkey, "Added To WishList Successfully ! ");
              }

            },child:
            Text("Add To WishList",style: TextStyle(color: CustomColors.blueColor),),
              borderSide: BorderSide(color: CustomColors.blueColor,width: 1.5),highlightElevation: 10,),)
          ],
        ),
        SizedBox(height: ScreenSizeInfo.heightInfo,),
        Text("Description:",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "fontStyle3",fontSize: 23,color: CustomColors.greenColorlight),),

        Text("${widget.descirption}",style: TextStyle(
            fontFamily: "fontStyle3",fontSize: 15,color: CustomColors.blueColor),textAlign: TextAlign.justify,),


      ],
    ),):Center(child: MyIconSpinner());
  }

  Widget imagesWithViewPager(){
          return Column(
           // overflow: Overflow.visible,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height/2,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FutureBuilder(
                      future: producutsInfo,
                        builder: (context,snapshot){
                         if(snapshot.hasData){
                              List<ProductImages> prod=snapshot.data.productImages;
                              len=prod.length;
                              //print(len);
                             // print(prod[0].src);
                             return CarouselSlider.builder(
                                 itemCount: prod.length,
                                 itemBuilder: (context,index){
                                   return Stack(
                                     alignment: Alignment.center,
                                     overflow: Overflow.visible,
                                     children: [
                                       Center(child: CupertinoActivityIndicator(),),
                                       Container(
                                         height: MediaQuery.of(context).size.height/1.5,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(15),
                                           image: DecorationImage(image:NetworkImage(prod[index].src),fit: BoxFit.fill),
                                         ),
                                       ),

                                     ],
                                   );
                                 }, options: CarouselOptions(
                               onPageChanged: (index, reason) {
                                 setState(() {
                                   currentpage=index;
                                 });
                               },
                               scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                 enlargeCenterPage: true,
                             //  initialPage: currentpage,
                                 viewportFraction: 1.0,
                               height: MediaQuery.of(context).size.height/1.5
                             ));
                         }
                      return Center(child: MyIconSpinner());
                    }),

                  ],
                ),
              ), indicators(),
            ],
          );
  }

  Widget reviewAndComments(){
    return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
    ),
      elevation: 10,
      child: InkWell(
        hoverColor: Colors.black12,
        onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>UserFeedBackPage(image: widget.image,product_id: widget.productId,)));
        },
        child: Container(
          height: ScreenSizeInfo.heightInfo*5,
          width: MediaQuery.of(context).size.width/1.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: Center(child: Text("Review and Comment",style:
              TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor,fontSize: 12),textAlign: TextAlign.center,))),
              SizedBox(width: 2,),
              Icon(Icons.keyboard_arrow_right_sharp,color: CustomColors.greenColorlight),
            ],
          ),
        ),
      ),
    );
  }

  Widget indicators(){
    return
      Container(
        margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int a=0;a< len;a++)
                a==currentpage ? circleBar(true):circleBar(false)
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
  Widget CalculateOldPrice(dynamic value){
  double funckingOutPut=double.parse(value)+double.parse(value);
  return Text("${funckingOutPut}\$",style:TextStyle(fontWeight: FontWeight.bold,fontFamily: "fontStyle3",decoration: TextDecoration.lineThrough));
}


Widget gettingProductReviews(dynamic product_id){
  return Container(
    margin: EdgeInsets.all(20),
    child: FutureBuilder(
      future: reviewList,
        builder: (context,snapshot){
      if(snapshot.hasData){
        return snapshot.data.length !=0 ? ListView.builder(
            shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
            itemBuilder: (context,index){
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(3),
                      height: ScreenSizeInfo.heightInfo*7,
                      width: ScreenSizeInfo.heightInfo*7,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),child: Center(child: Text(snapshot.data[index].userName[0].toUpperCase(),style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.whiteColor),),),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data[index].userEmail,style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor,fontSize: 12),),
                        Text(snapshot.data[index].userReview,style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor,fontSize: 12),),
                        Container(
                          height: ScreenSizeInfo.heightInfo,
                          margin: EdgeInsets.all(4),
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                             // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data[index].userGivenRating.toInt(),
                              itemBuilder: (context,index){
                              return Icon(Icons.star_rate,color: CustomColors.yellowColor);
                          }),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,height: 1,color: CustomColors.greenColorlight,),
                SizedBox(width: ScreenSizeInfo.heightInfo,),

              ],
            ),
          );
        }):Container();
      }
      return CupertinoActivityIndicator();



    }),
  );
}

Widget productSelectionInfo(){
  return Container(
    height: ScreenSizeInfo.heightInfo*6,
    width: double.infinity,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics:ClampingScrollPhysics(),
        itemCount: _singleProductBlock.singleProductInfo.length,
        itemBuilder: (context,index){

      return InkWell(
        onTap: (){
          setState(() {
            currentIndex=index;
          });

        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
           // color: currentIndex ==index ? CustomColors.blueColor:Colors.black12.withOpacity(0.1),
            border: currentIndex==index ? Border.all(color: CustomColors.blueColor,width: 2):Border.all(color: CustomColors.whiteColor),
          ),
          margin: EdgeInsets.all(ScreenSizeInfo.heightInfo-4),
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
            _singleProductBlock.singleProductInfo[index].option1=="Default Title" ?
            Text("Price"): Text("${_singleProductBlock.singleProductInfo[index].option1}"),
              SizedBox(width: 3,),
              Text("${_singleProductBlock.singleProductInfo[index].price} \$",style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.greenColorlight),),
            ],
          ),
        ),
      );
    }),
  );
}


}
