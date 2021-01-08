class WishListModel{
  String catId,product_id,product_name,product_image,product_price,product_quantity;
  WishListModel({this.product_price,this.product_quantity,this.product_id,this.product_name,this.product_image,this.catId});
  Map<String, dynamic> toMap() {
    return {
      'product_id': product_id,
      'product_name': product_name,
      'product_price': product_price,
      'product_quantity':product_quantity,
      'product_image':product_image,
      'cat_id':catId,
    };
  }


}