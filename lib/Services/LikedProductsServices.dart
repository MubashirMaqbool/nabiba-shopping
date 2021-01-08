import 'package:flutter/cupertino.dart';
import 'package:nabiba_app/Models/wisListModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LikedProductsServices extends ChangeNotifier{
  String path="";
  bool isLiked=false;
  Future<Database> initializeDbServices() async{
    Database database=await openDatabase(
      path=  join(await getDatabasesPath(), 'likedProducts_services'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE wishList(product_id TEXT PRIMARY KEY,"
              " product_name TEXT,product_price TEXT,product_quantity TEXT,product_image TEXT,cat_id TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }
  delDatabase() async{
    await deleteDatabase(path);
    print("Deleted ");
  }

  Future<void> addToWishList(WishListModel wishListModel) async{
    Database _database=await initializeDbServices();
       _database.insert("wishList", wishListModel.toMap());
       print("DATA INSERTED SUCCESSFULLY......................");
       notifyListeners();

  }

  Future<bool> checkProductInWishList(String productId) async{
    Database database=await initializeDbServices();
    var result=await database.query('wishList',where: 'product_id=?',whereArgs: [productId]);
    if(result.length>0){
      isLiked=true;
    }
    else{
      isLiked=false;
    }
    return isLiked;
  }

  Future<List<WishListModel>> getLikedProductsInfo() async{
    Database _database=await initializeDbServices();
    List<WishListModel> likedProductList=[];
    var result=await _database.query("wishList");
    result.forEach((info){
      WishListModel  wishListModel=WishListModel(catId: info['catId'],product_image: info['product_image'],
          product_name: info['product_name'],product_price: info['product_price'],product_quantity: info['product_quantity'],product_id: info['product_id']);
      likedProductList.add(wishListModel);
    });
    print(likedProductList);
    return  likedProductList;
  }


  Future<void> delItems(dynamic product_id) async{
    Database database=await initializeDbServices();
    await database.delete("wishList",where: "product_id=?",whereArgs: [product_id]);
    notifyListeners();

  }


}