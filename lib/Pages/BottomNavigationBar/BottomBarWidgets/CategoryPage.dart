import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_delegate_ext/rendering/grid_delegate.dart';
import 'package:html/parser.dart';
import 'package:nabiba_app/ApiUtils/CategoryApiUtils.dart';
import 'package:nabiba_app/ApiUtils/SubCategoryApiUtils.dart';
import 'package:nabiba_app/Models/CategoryModel.dart';
import 'package:nabiba_app/Models/SubCategoryModel.dart';
import 'package:nabiba_app/Models/wisListModel.dart';
import 'package:nabiba_app/Pages/BottomNavigationBar/SingleProductInfo.dart';
import 'package:nabiba_app/ReuseableWidgets/CustomLoadingBar.dart';
import 'package:nabiba_app/ReuseableWidgets/CustomToast.dart';
import 'package:nabiba_app/ReuseableWidgets/SnakBarWidget.dart';
import 'package:nabiba_app/Services/LikedProductsServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/customImagesIconsLink.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/stringWithStyle.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class CategoryPage extends StatefulWidget {
  dynamic scf_key;
  CategoryPage({this.scf_key});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int currentPage=0;
  String catID="";
  int count=0;
  Future<List<SubCategoryModel>> subCategoryList;
  Future<List<CategoryModel>> categoryData;
  CategoryApiUtils categoryApiUtils=CategoryApiUtils();
  SubCategoryApiUtils subCategoryApiUtils;
  LikedProductsServices likedProductsServices;
  WishListModel wishListModel=WishListModel();
  @override
  void initState() {
      categoryData=categoryApiUtils.categoryApiCalling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subCategoryApiUtils=Provider.of<SubCategoryApiUtils>(context);
    likedProductsServices=Provider.of<LikedProductsServices>(context);
    return Container(
      child: Column(
          children: [
            categoryInfo(),
            SizedBox(height: 10,),
           Expanded(child: subcategoryDesignWithData(),)
          ],
        ),
    );
  }

  Widget selectCategoryTitle(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
      child: Center(child: Text("Please Select Category",style: StringWithStyle.categoryTitleStyle)),
    );
  }

Widget categoryInfo(){
    return Container(
      height: ScreenSizeInfo.heightInfo*7,
      child: FutureBuilder(
        future: categoryData,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                physics:AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  String catId=snapshot.data[index].categoryId;
                  String catTitle=snapshot.data[index].categoryTitle;
                  if(currentPage==index){
                     subCategoryList= subCategoryApiUtils.subCategoryApiCalling(catId);

                  }
                  return categoryButtonDesign(index,catId,catTitle);
                }
            );

          }
          return Center(child: CupertinoActivityIndicator(),);
        },

      )
    );
}

  Widget categoryButtonDesign(dynamic index,dynamic id,dynamic title){
    return GestureDetector(
      onTap: (){
        setState(() {
          currentPage=index;
        });

      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.all(ScreenSizeInfo.heightInfo-5),
               padding: EdgeInsets.all(ScreenSizeInfo.heightInfo),
                child:  Center(child: Text(title,textAlign: TextAlign.center,
                style: currentPage==index ? TextStyle(fontFamily: "fontStyle3",fontSize: 14,fontWeight: FontWeight.bold,color: CustomColors.greenColorlight):
                TextStyle(fontFamily: "fontStyle3",fontSize: 12,fontWeight: FontWeight.bold,color: CustomColors.blueColor))),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            // color: currentPage ==index ? CustomColors.blueColor:Colors.black12.withOpacity(0.1)
            ),

              ),
          AnimatedContainer(
            duration: Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: 100,
            height: 3,color: currentPage==index ?  CustomColors.greenColorlight : Colors.transparent,)
        ],
      ),

    );
  }
  Widget subCategoryInfo(){
    return subCategoryApiUtils.isLoading ? Center(child: MyIconSpinner()): FutureBuilder(
       future: subCategoryList,
        builder: (context,snapshot){
      if(snapshot.hasData){
        return GridView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            gridDelegate:XSliverGridDelegate( crossAxisCount: 2,
                smallCellExtent: ScreenSizeInfo.heightInfo*35,
                bigCellExtent: ScreenSizeInfo.heightInfo*35,
                isFirstCellBig: true),
            itemBuilder: (_,index) {
              SubCategoryImage images=snapshot.data[index].subCategoryImage;
              return GestureDetector(
                onTap: (){

                  final document = parse(snapshot.data[index].body_html);
                  final String parsedString = parse(document.body.text).documentElement.text;
                 String desc= parsedString.replaceAll("\n", " ");
                  print('body html ==>>>>${parsedString}');
                  Navigator.push(context,
                      PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500),
                          child: SingleProductInfo(title:snapshot.data[index].title
                            ,image: images.src,productId: snapshot.data[index].id,catID: catID,descirption: desc,)));
                },
                child: Stack(
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      elevation: ScreenSizeInfo.heightInfo,
                      child: Column(
                        children: [
                          Container(
                            height: ScreenSizeInfo.heightInfo*27,
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.center,
                              children: [
                                Center(child: CupertinoActivityIndicator()),
                                Container(
                                  decoration:
                                  BoxDecoration(
                                    //  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      image: DecorationImage(image: NetworkImage(images.src),fit: BoxFit.cover)),),
                              ],
                            ),
                          ),
                          Flexible(child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Text(snapshot.data[index].title,
                                textAlign: TextAlign.center,style: StringWithStyle.productTextStyle,)
                            ),
                          ))
                        ],
                      ),
                    ),
                    Positioned(
                      top: ScreenSizeInfo.heightInfo-2,
                        right: ScreenSizeInfo.heightInfo-2,
                        child: getLikedProducts(snapshot.data[index].id)),
                  ],
                ),
              );
            });
      }
      return Center(child: MyIconSpinner(),);
    });
  }
Widget getLikedProducts(dynamic id){
    return FutureBuilder(
      future: likedProductsServices.checkProductInWishList(id),
      builder: (context,snapshotLiked){
        if(snapshotLiked.hasData && snapshotLiked.data){
          return  Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenSizeInfo.heightInfo*5)),
            child: Container(
              padding: EdgeInsets.all(ScreenSizeInfo.heightInfo),
                child: Center(child: Icon(ImagesIconsLink.heartIcon,color: CustomColors.blueColor,)))
          );
        }
        else{
          return Container();
        }
      },

    );
}



Widget subcategoryDesignWithData(){
  return subCategoryApiUtils.isLoading ? Center(child: MyIconSpinner()): FutureBuilder(
      future: subCategoryList,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                SubCategoryImage images=snapshot.data[index].subCategoryImage;
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Stack(
                       children: [
                         InkWell(
                           onTap: (){
                             final document = parse(snapshot.data[index].body_html);
                             final String parsedString = parse(document.body.text).documentElement.text;
                             String desc= parsedString.replaceAll("\n", " ");
                             print('body html ==>>>>${parsedString}');
                             Navigator.push(context,
                                 PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500),
                                     child: SingleProductInfo(title:snapshot.data[index].title
                                       ,image: images.src,productId: snapshot.data[index].id,catID: catID,descirption: desc,)));
                           },
                           child: Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(13),
                             ),
                             clipBehavior: Clip.antiAlias,
                             elevation: ScreenSizeInfo.heightInfo-5,
                             child: Stack(
                               alignment: Alignment.center,
                               overflow: Overflow.visible,
                               children: [
                                 Center(child: CupertinoActivityIndicator(),),
                                 Container(
                                   height: MediaQuery.of(context).size.height/3,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(13)),
                                     image: DecorationImage(
                                       image: NetworkImage(images.src),fit: BoxFit.fill
                                     )
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         Positioned(
                             right: ScreenSizeInfo.heightInfo*2.5,
                             bottom:ScreenSizeInfo.heightInfo*2.5,
                             child: Card(
                               elevation: 10,
                               child: Container(
                           height: ScreenSizeInfo.heightInfo*5,
                           width: MediaQuery.of(context).size.width/3.5,
                          // color: Colors.black12,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                         InkWell(
                                           hoverColor: Colors.black12,
                                           onTap: (){
                                             final document = parse(snapshot.data[index].body_html);
                                             final String parsedString = parse(document.body.text).documentElement.text;
                                             String desc= parsedString.replaceAll("\n", " ");
                                             print('body html ==>>>>${parsedString}');
                                             Navigator.push(context,
                                                 PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500),
                                                     child: SingleProductInfo(title:snapshot.data[index].title
                                                       ,image: images.src,productId: snapshot.data[index].id,catID: catID,descirption: desc,)));
                                           },
                                             child: Icon(Icons.remove_red_eye,color: CustomColors.blueColor,size: 20,)),
                                          Container(height: 20,width: 1,color: Colors.blueAccent,),
                                          InkWell(
                                            hoverColor: Colors.black12,
                                            onTap: () async{
                                              if(await likedProductsServices.checkProductInWishList(snapshot.data[index].id.toString())){

                                                CustomToast.showToast("Already Added To WishList");
                                              }
                                              else{

                                                wishListModel.product_id=snapshot.data[index].id.toString();
                                                wishListModel.product_name=snapshot.data[index].title;
                                                wishListModel.product_image=images.src;
                                                wishListModel.product_quantity="00";
                                                wishListModel.product_price="00";
                                                wishListModel.catId="00";
                                                likedProductsServices.addToWishList(wishListModel);
                                                CustomToast.showToast("Added To WishList Successfully");

                                              }

                                            },
                                              child: Icon(ImagesIconsLink.heartIcon,color: Colors.blueAccent,size: 20,)),
                                   ],
                                 ),
                         ),
                             )),
                       ],
                     ),
                       Container(
                         margin: EdgeInsets.all(3),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Flexible(
                               child: Text(snapshot.data[index].title,
                               textAlign: TextAlign.center,style: StringWithStyle.productTextStyle,),
                             ),
                             getLikedProductsInfo(snapshot.data[index].id),
                           ],
                         ),
                       ),
                     Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.black12,margin: EdgeInsets.all(3),)
                   ],
                 );
          });
        }
        return Center(child: MyIconSpinner(),);
      });
}
  Widget getLikedProductsInfo(dynamic id){
    return FutureBuilder(
      future: likedProductsServices.checkProductInWishList(id),
      builder: (context,snapshotLiked){
        if(snapshotLiked.hasData && snapshotLiked.data){
          return  Container(
              padding: EdgeInsets.all(ScreenSizeInfo.heightInfo),
              child: Center(child: Icon(ImagesIconsLink.heartIcon,color: Colors.redAccent,)));
        }
        else{
          return Container(
              padding: EdgeInsets.all(ScreenSizeInfo.heightInfo),
              child: Center(child: Icon(ImagesIconsLink.heartIconOuline,color: Colors.redAccent,)));

        }
      },

    );
  }

}
