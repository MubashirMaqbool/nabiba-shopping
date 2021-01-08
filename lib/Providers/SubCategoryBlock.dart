import 'package:flutter/cupertino.dart';
import 'package:nabiba_app/Models/SubCategoryModel.dart';

class SubCategoryBlock extends ChangeNotifier{
  bool loading=false;
  setLoading(bool loading){
    this.loading=loading;
    notifyListeners();
  }

  List<SubCategoryModel> subcategoryList=[];
   setSubCategoryData(List<SubCategoryModel> subCategoryData){
     subcategoryList=subCategoryData;
     notifyListeners();
   }
   Future<List<SubCategoryModel>> getSubCategoryData() async{
     return subcategoryList;
   }
}