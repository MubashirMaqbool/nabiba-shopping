import 'package:flutter/cupertino.dart';
import 'package:nabiba_app/Models/SingleProductModel.dart';

class  SingleProductBlock extends ChangeNotifier{
  List<SingleProductModel> singleProductInfo=[];
  bool loading=false;

  setLoading(bool loading){
    this.loading=loading;
    notifyListeners();
  }

  setSingleProductInfo(List<SingleProductModel> singleProductData){
    singleProductInfo=singleProductData;
    notifyListeners();
  }

  getSingleProductInfo(){
    return singleProductInfo;
  }
}