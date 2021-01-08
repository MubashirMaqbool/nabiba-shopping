import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/Models/orderModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class UserOrderServices extends ChangeNotifier{
  Future<Database> initializeDbServices() async{
    Database database=await openDatabase(
      join(await getDatabasesPath(), 'order_services'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE orderInfo(productid INTEGER PRIMARY KEY,"
              " product_name TEXT,product_price REAL,product_quantity INTEGER,product_image TEXT,variant_id INTEGER,order_date TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }
  Future<void> saveOrder(CartModel cartModel) async{

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    var data={
      "productid":cartModel.product_id,
      "product_name":cartModel.product_name,
      "product_price":cartModel.product_price,
      "product_quantity":cartModel.product_quantity,
      "product_image":cartModel.product_image,
      "variant_id":cartModel.variant_id,
      "order_date":formattedDate.toString()
    };
    Database _database=await initializeDbServices();
    _database.insert("orderInfo", data);
    notifyListeners();

  }

Future<List<OrderModel>> getOrderInfo() async{
  Database _database=await initializeDbServices();
  List<OrderModel> orderList=[];
  var result=await _database.query("orderInfo");
  result.forEach((info){
    OrderModel  wishListModel=OrderModel(variant_id: info['variant_id'],product_id: info['productid'],
        product_quantity: info['product_quantity'],product_price: info['product_price'],
        product_name: info['product_name'],product_image: info['product_image'],date: info['order_date']);
    orderList.add(wishListModel);
  });
 // print(likedProductList);
  return  orderList;
}
}