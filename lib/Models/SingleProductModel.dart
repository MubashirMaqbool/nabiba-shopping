class SingleProductModel{
  dynamic price,weight,weight_unit,inventory_quantity,old_inventory_quantity,compare_at_price,variant_id,size_title,option1,option2,option3;
  SingleProductModel({this.price,this.weight,this.weight_unit,
    this.inventory_quantity,this.old_inventory_quantity,
    this.compare_at_price,this.variant_id,this.size_title,this.option1,this.option2,this.option3});
  factory SingleProductModel.fromJson(Map<String,dynamic> json){
    return SingleProductModel(
    compare_at_price: json['compare_at_price'].toString(),
      weight_unit: json['weight_unit'].toString(),
      weight: json['weight'].toString(),
      inventory_quantity: json['inventory_quantity'].toString(),
      price: json['price'].toString(),
      old_inventory_quantity: json['old_inventory_quantity'].toString(),
        variant_id: json['id'],
      option1: json['option1'],
      option2: ['option2'],
      option3: json['option3'],
      size_title: json['title']
    );
  }



}