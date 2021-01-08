import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nabiba_app/Models/ProductsModel.dart';
import 'package:nabiba_app/Models/SingleProductModel.dart';
import 'package:nabiba_app/Providers/SingleProductBlock.dart';
class SingleProductApiUtils{

  Future<void> singleProductInfoApiCalling(dynamic productId,SingleProductBlock singleProductBlock) async{
    var url="https://980e22c91a1b8b82fbe00f186350a474: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@natistefastore.myshopify.com/admin/api/2020-10/products/${productId}.json?fields=id,title,image,variants";
         var response=await http.get(url);
         if(response.statusCode==200){
              var data=jsonDecode(response.body);
              var singleProdcutInfo=data['product']['variants'].cast<Map<String, dynamic>>();
             // print("${singleProdcutInfo}");
              List<SingleProductModel> singleProductInfoList= singleProdcutInfo.map<SingleProductModel>((json) => SingleProductModel.fromJson(json)).toList();
              singleProductBlock.setSingleProductInfo(singleProductInfoList);

         }
         else{

         }
  }
  Future<ProductsModel> singleProductInfosApiCalling(dynamic productId) async{
    var url="https://980e22c91a1b8b82fbe00f186350a474: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@natistefastore.myshopify.com/admin/api/2020-10/products/${productId}.json?fields=id,title,image,variants,images";
    var response=await http.get(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      var singleProdcutInfo=data['product'];
  ProductsModel productsModel=ProductsModel.fromJson(singleProdcutInfo);
  return productsModel;
    }
    else{

    }
  }
}