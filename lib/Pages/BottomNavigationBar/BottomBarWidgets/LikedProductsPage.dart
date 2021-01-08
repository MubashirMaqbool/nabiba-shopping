import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_delegate_ext/rendering/grid_delegate.dart';
import 'package:nabiba_app/Models/wisListModel.dart';
import 'package:nabiba_app/ReuseableWidgets/BottomSheetWidget.dart';
import 'package:nabiba_app/ReuseableWidgets/CustomLoadingBar.dart';
import 'package:nabiba_app/Services/LikedProductsServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/stringWithStyle.dart';
import 'package:provider/provider.dart';

class LikedProductsPage extends StatefulWidget {
  @override
  _LikedProductsPageState createState() => _LikedProductsPageState();
}

class _LikedProductsPageState extends State<LikedProductsPage> {
  LikedProductsServices likedProductsServices;
  Future<List<WishListModel>> wishListInfo;
  @override
  void initState() {
  //  LikedProductsServices likedProductsServices=Provider.of<LikedProductsServices>(context,listen: false);
   //wishListInfo=  likedProductsServices.getLikedProductsInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    likedProductsServices = Provider.of<LikedProductsServices>(context);
    wishListInfo=  likedProductsServices.getLikedProductsInfo();

    return Container(
      child: Column(
        children: [
          Expanded(child: likedProductsList()),
        ],
      ),
    );
  }



  Widget likedProductsData() {
    return FutureBuilder(
      future:likedProductsServices.getLikedProductsInfo() ,
      builder: (context, snapshot) {
        if(snapshot.hasData){
       // print("liked post ${snapshot.data.length}");
          return snapshot.data.length != 0 ?   GridView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              gridDelegate:XSliverGridDelegate( crossAxisCount: 2,
                  smallCellExtent: ScreenSizeInfo.heightInfo*35,
                  bigCellExtent: ScreenSizeInfo.heightInfo*35,
                  isFirstCellBig: true),
              itemBuilder: (_,index) {
                return Stack(
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
                            height: MediaQuery.of(context).size.height/3,
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.center,
                              children: [
                                Center(child: CupertinoActivityIndicator()),
                                Container(
                                  decoration:
                                  BoxDecoration(
                                    //  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      image: DecorationImage(image: NetworkImage(snapshot.data[index].product_image),fit: BoxFit.fill)),),
                              ],
                            ),
                          ),
                          Flexible(child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                                child: Text(snapshot.data[index].product_name,
                                  textAlign: TextAlign.center,style: StringWithStyle.productTextStyle,)
                            ),
                          ))
                        ],
                      ),
                    ),
                     Positioned(
                         top: ScreenSizeInfo.heightInfo-2,
                         right: ScreenSizeInfo.heightInfo-2,
                         child: deleteItem(snapshot.data[index].product_id)),
                  ],
                );
              }): Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenSizeInfo.heightInfo*35,
                height: ScreenSizeInfo.heightInfo*40,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/likedLogo.png'))),),
              Text("WishList is Empty !", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontFamily: 'fontStyle3',color: CustomColors.blueColor))
            ],
          ),);
        }

        return Center(child: MyIconSpinner());
      },
    );
  }

  Widget deleteItem(dynamic id){
    return  InkWell(
      hoverColor: CustomColors.blueColor,
      onTap: () async{
        await likedProductsServices.delItems(id);
      },
      child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenSizeInfo.heightInfo*5)),
          child: Container(
              padding: EdgeInsets.all(ScreenSizeInfo.heightInfo),
              child: Center(child: Icon(Icons.delete_forever,color: CustomColors.blueColor,)))
      ),
    );
  }

  Widget  likedProductsList(){
    return FutureBuilder(
      future: wishListInfo,//likedProductsServices.getLikedProductsInfo() ,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return snapshot.data.length != 0 ?  ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (_,index) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: [
                        Center(child: CupertinoActivityIndicator(),),
                        Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
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
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot.data[index].product_image),fit: BoxFit.fill
                                        )
                                    ),
                                  ),
                                ],
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        hoverColor: Colors.black12,
                                        onTap: () async{
                                          await likedProductsServices.delItems(snapshot.data[index].product_id);
                                        },
                                          child: Icon(Icons.delete_forever,color: CustomColors.redColor,)),
                                      Container(height: 20,width: 1,color: CustomColors.blueColor,),
                                      InkWell(
                                          hoverColor: Colors.black12,
                                          onTap: (){
                                           BottomSheetWidget.
                                           showBottomBar(context,snapshot.data[index].product_image,snapshot.data[index].product_name);
                                          },
                                          child: Icon(Icons.remove_red_eye,color: CustomColors.blueColor,)),
                                    ],
                                  ),
                            ),))
                          ],
                        ),

                      ],
                    ),
                    Text(snapshot.data[index].product_name,
                      textAlign: TextAlign.center,style: StringWithStyle.productTextStyle,),
                    Container(
                      margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
                      width: MediaQuery.of(context).size.width,height: 2,color: Colors.black12,)
                  ],
                );
              }): Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenSizeInfo.heightInfo*35,
                height: ScreenSizeInfo.heightInfo*40,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/likedLogo.png'))),),
              Text("WishList is Empty !", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontFamily: 'fontStyle3',color: CustomColors.blueColor))
            ],
          ),);
        }

        return Center(child: MyIconSpinner());
      },
    );
  }
}
