import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nabiba_app/ApiUtils/ApiUtils.dart';
import 'package:nabiba_app/Models/CategoryModel.dart';


class CategoryApiUtils{

  Future<List<CategoryModel>> categoryApiCalling() async{
    List<CategoryModel> categorylist=[];
    var response=await http.get(ApiUtils.categoryApiUrl);
    if(response.statusCode==200){
      var categoryData=jsonDecode(response.body);
      final parsed = categoryData['custom_collections'].cast<Map<String, dynamic>>();
      categorylist = parsed.map<CategoryModel>((json) => CategoryModel.fromJason(json)).toList();
      return categorylist;
    }

  else{
    print("cat_error");

    }
  }
}