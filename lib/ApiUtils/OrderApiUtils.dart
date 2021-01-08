import 'dart:convert';
import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/Models/UserInfoModel.dart';
import 'package:http/http.dart' as http;
class OrderApiUtils{


   Future<String> sendDataToServer(List<CartModel> cartMOdel,dynamic total,UserInfoModel userInfoModel) async{
      var responseMessage="";
     dynamic data= {
       "order": {
         "line_items": cartMOdel.map((e) => e.toJson()).toList(),
         "customer": {
           "first_name": userInfoModel.fname,
           "last_name": userInfoModel.lname,
           "email": userInfoModel.userEmail
         },
         "shipping_address": {
           "first_name": userInfoModel.fname,
           "last_name": userInfoModel.lname,
           "address1": userInfoModel.address,
           "phone": userInfoModel.phone,
           "city": userInfoModel.city,
           "province": userInfoModel.state,
           "country": userInfoModel.country,
           "zip": userInfoModel.zipCode,

         },
         "transactions": [
           {
             "kind": "sale",
             "status": "success",
             "amount": total
           }
         ],

       }
     };

    var jsonData=jsonEncode(data);
    print(jsonData);
    var response= await http.post('https://980e22c91a1b8b82fbe00f186350a474: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@natistefastore.myshopify.com/admin/api/2020-10/orders.json',
       headers: <String, String>{
        "X-Shopify-Access_Token":"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",
         "accept": "application/json",
         "content-type": "application/json"
      },
       body: jsonData
    );
       if(response.statusCode==201){
        responseMessage="Success";

       }
       else{
         var res=jsonDecode(response.body);
         responseMessage="Failed to add Data";
       }
  return responseMessage;
   }
}