class OrderModel {
  dynamic product_id, product_name, product_image;
  dynamic product_price, product_quantity, variant_id, date;

  OrderModel({this.product_id, this.product_name, this.product_price,
    this.product_quantity, this.product_image, this.variant_id, this.date});
}