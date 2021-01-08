import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nabiba_app/Services/OrderServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:nabiba_app/StylesUtils/StringUtils/stringWithStyle.dart';
import 'package:provider/provider.dart';
class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  UserOrderServices orderServices;
  @override
  Widget build(BuildContext context) {
    orderServices=Provider.of<UserOrderServices>(context);
    return Container(
      child: orderHistoryInfo(),
    );
  }
  Widget orderHistoryInfo(){
    return FutureBuilder(
      future:orderServices.getOrderInfo(),
        builder: (context,snapshot){
           if(snapshot.hasData){
             return snapshot.data.length != 0 ? ListView.builder(
               physics: BouncingScrollPhysics(),
                 itemCount: snapshot.data.length,
                 itemBuilder: (context,index){
                      return Card(
                         elevation: 10,
                         child: Container(
                           height: ScreenSizeInfo.heightInfo*15,
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
                                             image: NetworkImage(snapshot.data[index].product_image))),),

                                 ],
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Flexible(child: Text(snapshot.data[index].product_name,style: StringWithStyle.productTextStyle),),
                                   Text("${snapshot.data[index].product_price} \$ ",
                                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "fontStyle3",color: CustomColors.greenColorlight),),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                     Text("Quantity : ",style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor,fontWeight: FontWeight.bold),),
                                     Text("${snapshot.data[index].product_quantity} ",style:
                                     TextStyle(fontFamily: 'fontStyle3',fontSize: 15,color: CustomColors.greenColorlight),),

                                   ],),
                                   Row(
                                     children: [
                                       Icon(Icons.calendar_today,size: 15,color: CustomColors.blueColor,),
                                       Text(" ${snapshot.data[index].date}",style:  TextStyle(fontFamily: 'fontStyle3',fontSize: 15,color: CustomColors.greenColorlight),)
                                     ],
                                   ),

                                 ],
                               )
                             ],
                           ),
                         ));
                 })
                 :Container(child: Center(child: Text("No Order History Yet ! ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "fontStyle3",color: CustomColors.greenColorlight),)),);
           }
           return Center(child: CupertinoActivityIndicator());

    });
  }
}
