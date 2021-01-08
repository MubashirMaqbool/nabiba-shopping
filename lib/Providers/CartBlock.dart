import 'package:flutter/cupertino.dart';
import 'package:nabiba_app/Models/CartModel.dart';

class CartBlock extends ChangeNotifier{
  int totalProducts=0;
  dynamic totalPrice=0;
  List<CartModel> productInfoList=[];

   setTotalPrice(dynamic totalPrice){
     this.totalPrice=totalPrice;
     notifyListeners();
   }
  setProductInfoList(List<CartModel> productInfoList){
       this.productInfoList=productInfoList;
       notifyListeners();
  }
  setTotalProducts(int totalProducts){
    this.totalProducts=totalProducts;
    notifyListeners();
  }
}