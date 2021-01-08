class CartModel{
  dynamic product_id,product_name,product_image;
  dynamic product_price,product_quantity,variant_id,date;

  CartModel({this.product_id, this.product_name, this.product_price,
      this.product_quantity,this.product_image,this.variant_id,this.date="00:00:00"});

  Map<String, dynamic> toMap() {
    return {
      'product_id': product_id,
      'product_name': product_name,
      'product_price': product_price,
      'product_quantity':product_quantity,
      'product_image':product_image,
      'variant_id':variant_id
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variant_id;
    data['quantity'] = this.product_quantity;
    return data;
  }
}