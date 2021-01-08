class ProductsModel{
  dynamic id,title;
  List<ProductImages> productImages;
  List<variants> variantList;
  ProductsModel({this.id,this.title,this.productImages,this.variantList});
  factory ProductsModel.fromJson(Map<String,dynamic> json){
    var listImages = json['images'] as List;
    var variantList=json['variants'] as List;
    List<ProductImages> imagesList = listImages.map((i) => ProductImages.fromJson(i)).toList();
    List<variants> variant_list = variantList.map((i) => variants.fromJson(i)).toList();
    return ProductsModel(
      id:json['id'],
      title: json['title'],
      productImages:imagesList,
        variantList:variant_list

    );
  }

}
class ProductImages{
dynamic id,src,alt;
 ProductImages({this.id,this.src,this.alt});
 factory ProductImages.fromJson(Map<String,dynamic> json){
   return ProductImages(
     id: json['id'],
     src: json['src'],
     alt: json['alt']
   );
 }
}

class variants{
  dynamic price,weight,weight_unit,inventory_quantity,old_inventory_quantity,compare_at_price,variant_id;
  variants({this.price,this.weight,this.weight_unit,
    this.inventory_quantity,this.old_inventory_quantity,
    this.compare_at_price,this.variant_id});
  factory variants.fromJson(Map<String,dynamic> json){
    return variants(
        compare_at_price: json['compare_at_price'].toString(),
        weight_unit: json['weight_unit'].toString(),
        weight: json['weight'].toString(),
        inventory_quantity: json['inventory_quantity'].toString(),
        price: json['price'].toString(),
        old_inventory_quantity: json['old_inventory_quantity'].toString(),
        variant_id: json['id']
    );
  }
}