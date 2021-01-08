import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:nabiba_app/Models/SubCategoryModel.dart';
import 'package:http/http.dart' as http;
class SubCategoryApiUtils extends ChangeNotifier{
  bool isLoading=false;
  Future<List<SubCategoryModel>> subCategoryApiCalling(var categoryId) async{
    isLoading=true;
    List<SubCategoryModel> subCategorylist=[];
       var subCategoryProductUrl="https://980e22c91a1b8b82fbe00f186350a474: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@natistefastore.myshopify.com/admin/api/2020-10/collections/${categoryId}/products.json?fields=id,title,image,options,body_html";
       var response=await http.get(subCategoryProductUrl);
       if(response.statusCode==200){
         var subCategoryData=jsonDecode(response.body);
         final parsed = subCategoryData['products'].cast<Map<String, dynamic>>();
         subCategorylist= parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
         isLoading=false;
          notifyListeners();
          return subCategorylist;
       }
       else{
         print("error in sub cat..");

       }




  }
}