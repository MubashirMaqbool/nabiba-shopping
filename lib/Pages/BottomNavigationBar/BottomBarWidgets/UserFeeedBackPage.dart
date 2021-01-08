import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nabiba_app/Models/ReviewModel.dart';
import 'package:nabiba_app/ReuseableWidgets/CustomToast.dart';
import 'package:nabiba_app/ReuseableWidgets/FormFieldsUtils.dart';
import 'package:nabiba_app/Services/FirebaseServices/ReviewsServices.dart';
import 'package:nabiba_app/StylesUtils/Colors/colors.dart';
import 'package:nabiba_app/StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';
class UserFeedBackPage extends StatefulWidget {

  dynamic image,product_id;
  UserFeedBackPage({this.image,this.product_id});
  @override
  _UserFeedBackPageState createState() => _UserFeedBackPageState();
}

class _UserFeedBackPageState extends State<UserFeedBackPage> {
  ReviewModel reviewModel=ReviewModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Review",style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.blueColor),),
          centerTitle: true,
          backgroundColor: CustomColors.whiteColor,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)))
            },
              child: Icon(Icons.arrow_back,color: CustomColors.blueColor,)),
        ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(ScreenSizeInfo.heightInfo*2),
                    height: MediaQuery.of(context).size.height/2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        image: NetworkImage(widget.image),fit: BoxFit.cover
                      )
                    ),
                  ),
                  SizedBox(height: ScreenSizeInfo.heightInfo,),
                  userReviewForm(),
                ],
              ),
            ),
          )),
    );
  }
  Widget userReviewForm(){
    return Container(
      margin: EdgeInsets.all(ScreenSizeInfo.heightInfo*3),
      child: Form(
        key: _formKey,
          child: Column(children: [

        TextFormField(
          onSaved: (value){
            reviewModel.userEmail=value;
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
          decoration: FormFieldUtils.ratingInputDecorations("Enter Email", Icons.email),),
        SizedBox(height:ScreenSizeInfo.heightInfo),
        TextFormField(
          onSaved: (value){
            reviewModel.userName=value;
          },
          validator: (value){
            if(value.isEmpty){
              return "Enter Valid  Name";

            }

            return null;
          },
          textInputAction: TextInputAction.next,
          cursorColor: CustomColors.darkBlueColor,
          decoration: FormFieldUtils.ratingInputDecorations("Enter Name", Icons.account_circle),),
        SizedBox(height: ScreenSizeInfo.heightInfo,),
        TextFormField(
          onSaved: (value){
            reviewModel.userReview=value;
          },
          validator: (value){
            if(value.isEmpty){
              return "Review can not be empty";

            }

            return null;
          },
          textInputAction: TextInputAction.done,
          maxLines: 3,
          cursorColor: CustomColors.darkBlueColor,
          decoration: FormFieldUtils.ratingInputDecorations("Enter Your Review", Icons.rate_review_rounded),),
        SizedBox(height: ScreenSizeInfo.heightInfo,),
        RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context,_){
            return Icon(Icons.star_rate,color: CustomColors.yellowColor);
        }, onRatingUpdate: (rating){
              reviewModel.userGivenRating=rating;
        }),
        Container(
          width: double.infinity,
          child: RaisedButton(onPressed: () async{
              ReviewsServices rs=ReviewsServices();
            if(_formKey.currentState.validate()){
              _formKey.currentState.save();
              reviewModel.product_id=widget.product_id;
             String msg=  await rs.addUserReviews(reviewModel);
             CustomToast.showToast(msg);
             Navigator.pop(context);
            }

          },child: Text("Submitt Your Review",
            style: TextStyle(fontFamily: 'fontStyle3',color: CustomColors.whiteColor),),color: CustomColors.blueColor,),)

      ],)),
    );
  }
}
