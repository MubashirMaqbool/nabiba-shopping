import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nabiba_app/ApiUtils/OrderApiUtils.dart';
import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/Models/UserInfoModel.dart';
import 'package:nabiba_app/PaymentIntegrationPages/PayPalPage.dart';
import 'package:nabiba_app/Providers/CartBlock.dart';
import 'package:nabiba_app/ReuseableWidgets/FormFieldsUtils.dart';
import 'package:nabiba_app/Services/CartSqliteServices.dart';
import 'package:nabiba_app/Services/OrderServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
import 'package:provider/provider.dart';
class UserInfoPage extends StatefulWidget {
  List<CartModel> cartmodel;
  dynamic total;
  UserInfoPage({this.cartmodel,this.total});
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool isPaypallButtonShowing=false;
  final _formKey = GlobalKey<FormState>();
  UserInfoModel userInfoModel=UserInfoModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
      CustomColors.whiteColor, //or set color with: Color(0xFF0000FF)
    ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          backgroundColor:  CustomColors.blueColor,
          title: Text("Your Order",style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.whiteColor),),
        ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(ScreenSizeInfo.heightInfo),
              child: Column(
                children: [
                  SizedBox(height: ScreenSizeInfo.heightInfo,),
              Center(child: Text("Shipping Address",style: TextStyle(fontFamily: "fontStyle3",color: CustomColors.blueColor,fontSize: 20),)),
              SizedBox(height: ScreenSizeInfo.heightInfo*2,),
              userInfoForm(),
                ],
              ),
            ),
          )),
    );
  }

  Widget userInfoForm(){
    return Container(
      child: Form(
        key: _formKey,
          child: Column(
        children: [

          TextFormField(
            onSaved: (value){
              userInfoModel.userEmail=value;
            },

            validator: (value){
              if(value.isEmpty){
                return "Enter Valid Email Address";

              }
              else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                return 'Correct Your Email Format';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: CustomColors.darkBlueColor,
            decoration: FormFieldUtils.setInputDecorations("Email", Icons.email),),
          SizedBox(height: ScreenSizeInfo.heightInfo,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onSaved: (value){
                    userInfoModel.fname=value;
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid First Name";

                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: CustomColors.darkBlueColor,
                  decoration: FormFieldUtils.setInputDecorations("First Name", Icons.account_circle),),
              ),
              SizedBox(width: ScreenSizeInfo.heightInfo-2,),
              Expanded(
                child: TextFormField(
                  onSaved: (value){
                    userInfoModel.lname=value;
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid Last Name ";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: CustomColors.darkBlueColor,
                  decoration: FormFieldUtils.setInputDecorations("Last Name", Icons.account_circle),),
              ),


            ],
          ),
          SizedBox(height: ScreenSizeInfo.heightInfo,),
          TextFormField(
            onSaved: (value){
              userInfoModel.address=value;
            },
            validator: (value){
              if(value.isEmpty){
                return "Enter Valid Address";

              }
              return null;
            },
            textInputAction: TextInputAction.next,
            cursorColor: CustomColors.darkBlueColor,
            decoration: FormFieldUtils.setInputDecorations("Address", Icons.location_on),),
          SizedBox(height: ScreenSizeInfo.heightInfo,),
          TextFormField(
            onSaved: (value){
              userInfoModel.city=value;
            },
            validator: (value){
              if(value.isEmpty){
                return "Enter Valid  City Name";

              }

              return null;
            },
            textInputAction: TextInputAction.next,
            cursorColor: CustomColors.darkBlueColor,
            decoration: FormFieldUtils.setInputDecorations("City", Icons.location_city_rounded),),
          SizedBox(height: ScreenSizeInfo.heightInfo,),
          TextFormField(
            onSaved: (value){
              userInfoModel.phone=value;
            },
            validator: (value){
              if(value.isEmpty){
                return "Enter Valid Mobile No";

              }

              return null;
            },
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            cursorColor: CustomColors.darkBlueColor,
            decoration: FormFieldUtils.setInputDecorations("Mobile No", Icons.phone),),
          SizedBox(height: ScreenSizeInfo.heightInfo,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onSaved: (value){
                    userInfoModel.country=value;
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Country/Region Name";

                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: CustomColors.darkBlueColor,
                  decoration: FormFieldUtils.setRegionInputDecorations("Country/Region"),),
              ),
              SizedBox(width: ScreenSizeInfo.heightInfo-3,),
              Expanded(
                child: TextFormField(
                  onSaved: (value){
                    userInfoModel.state=value;
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid State Name";

                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: CustomColors.darkBlueColor,
                  decoration: FormFieldUtils.setRegionInputDecorations("State"),),
              ),
              SizedBox(width: ScreenSizeInfo.heightInfo-3,),
              Expanded(
                child: TextFormField(
                    onSaved: (value){
                      userInfoModel.zipCode=value;
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter Valid ZIP CODE";

                      }

                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  cursorColor: CustomColors.darkBlueColor,
                  decoration: FormFieldUtils.setRegionInputDecorations("ZIP Code")),
              ),
            ],
          ),
          SizedBox(height: ScreenSizeInfo.heightInfo*4,),
          Container(width: double.infinity,
              child: RaisedButton(onPressed: () async{
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  print("Email ${userInfoModel.userEmail}");
                  setState(() {
                    isPaypallButtonShowing=true;
                  });
                }
                else{
                  setState(() {
                    isPaypallButtonShowing=false;
                  });
                }
              },
                child: Text("Proceed Next",style: TextStyle(fontFamily: "fontStyle3",color: CustomColors.whiteColor)), color: CustomColors.blueColor,),),
          SizedBox(height: ScreenSizeInfo.heightInfo,),
          isPaypallButtonShowing ? payPallButton():Container(),

        ],
      )),
    );
  }
  Widget payPallButton(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Payment",style: TextStyle(fontFamily: 'fontStyle3',fontSize: 20,color: CustomColors.blueColor),),
        SizedBox(height: ScreenSizeInfo.heightInfo,),
        InkWell(
          onTap: (){
            if(_formKey.currentState.validate()){
              _formKey.currentState.save();
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PayPalPage(
                userInfoModel: userInfoModel,data: widget.cartmodel,price: widget.total.toStringAsFixed(2),
              )));
            }
          },
          child: Container(
            padding: EdgeInsets.all(ScreenSizeInfo.heightInfo),
            decoration: BoxDecoration(color: CustomColors.yellowColor),
            width: double.infinity,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset('assets/paypallogo.svg',width: 30,height: 20,)
                ),
                SizedBox(width: ScreenSizeInfo.heightInfo),
                RichText(text: TextSpan(
                  children: [
                       TextSpan(text: "Pay", style: TextStyle(fontFamily: 'fontStyle2',fontWeight: FontWeight.bold,color: CustomColors.paypalColor1)),
                    TextSpan(text: "Pal",style: TextStyle(fontFamily: 'fontStyle2',fontWeight: FontWeight.bold,color: CustomColors.paypalColor2))
                  ]
                ))
              ],
            )
          ),
        ),
      ],
    );
  }
}
