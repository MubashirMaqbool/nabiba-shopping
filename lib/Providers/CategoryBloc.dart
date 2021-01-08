import 'package:flutter/cupertino.dart';
import 'package:nabiba_app/Models/CategoryModel.dart';

class CategoryBlock extends ChangeNotifier{

   List<CategoryModel> categoryData=[];

   setCategoryData(List<CategoryModel> categoryData){
       this.categoryData=categoryData;
       notifyListeners();
   }
   Future<List<CategoryModel>> getCategoryData() async{
     return categoryData;
   }
}