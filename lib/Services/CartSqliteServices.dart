import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/Providers/CartBlock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class CartSqliteServices{
String path="";
 Future<Database> initializeDbServices() async{
  Database database=await openDatabase(
   path=  join(await getDatabasesPath(), 'cart_services'),
     onCreate: (db, version) {
       return db.execute(
         "CREATE TABLE productsInfo(product_id INTEGER PRIMARY KEY,"
             " product_name TEXT,product_price REAL,product_quantity INTEGER,product_image TEXT,variant_id INTEGER)",
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
 //.......InsertOrUpdate  ProductInfo.................//
 Future<void> insertOrUpdateProductsInfo(CartModel cartModel,int quantity,CartBlock cartBlock) async{
   Database _database=await initializeDbServices();
  if( await checkProductInCart(cartModel.product_id)){
  var result=  await _database.update("productsInfo", cartModel.toMap(),where: "product_id=?",whereArgs: [cartModel.product_id]);
    print("Data Updated Successfully ${result}");
    cartBlock.notifyListeners();
  }
  else{
    _database.insert("productsInfo", cartModel.toMap());
    print("DATA INSERTED SUCCESFULLY......................");
    cartBlock.notifyListeners();
  }
   //getProductsInfoInCart(cartBlock);
 }

 Future<bool> checkProductInCart(dynamic productId) async{
    Database database=await initializeDbServices();
    var result=await database.query('productsInfo',where: 'product_id=?',whereArgs: [productId]);
    if(result.length>0){
      return true;
    }
    else{
      return false;
    }
 }
 Future<void> countItemsInCart(CartBlock cartBlock)async{
   Database database=await initializeDbServices();
   final result=await database.rawQuery('SELECT COUNT(*) FROM productsInfo');
   int count = Sqflite.firstIntValue(result);
   cartBlock.setTotalProducts(count);

 }
   Future<void> getProductsInfoInCart(CartBlock cartBlock) async{
   List<CartModel> productList=[];
   Database database=await initializeDbServices();
   var result=await database.query("productsInfo");
   print(result);
  result.forEach((productInfo){
    CartModel cartModel=CartModel(product_id: productInfo['product_id'],product_quantity: productInfo['product_quantity'],
        product_price: productInfo['product_price'],
        product_name: productInfo['product_name'],product_image: productInfo['product_image'],variant_id: productInfo['variant_id']);
        productList.add(cartModel);
     });
       cartBlock.setProductInfoList(productList);
   }
   Future<void> getTotalProductsPrice(CartBlock cartBlock) async{
     Database database=await initializeDbServices();
    // var result = await database.rawQuery("SELECT SUM(product_price*product_quantity) as Total FROM productsInfo");
     var result2 = await database.rawQuery("SELECT SUM(product_price*product_quantity) as Total FROM productsInfo");
    // dynamic totalAmount=Sqflite.firstIntValue(result);
  //   print("totalamount===> ${result2.toList()}");
     var res=result2.toList();
      cartBlock.setTotalPrice(res[0]['Total']);

   }

   Future<void> delSpecificProduct(dynamic productID ,CartBlock cartBlock) async{
     Database database=await initializeDbServices();
     var result=await database.delete("productsInfo",where: "product_id=?",whereArgs: [productID]);
     print("delete Success==>");
      await   getProductsInfoInCart(cartBlock);

   }



}