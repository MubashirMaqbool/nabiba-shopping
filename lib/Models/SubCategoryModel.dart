class SubCategoryModel{
  String  id,title,body_html;
  SubCategoryImage subCategoryImage;
  SubCategoryModel({this.id,this.title,this.subCategoryImage,this.body_html});
  factory SubCategoryModel.fromJson(Map<String,dynamic> json){
    var subCatId=json['id'].toString();
    return SubCategoryModel(
      id: subCatId,
      title: json['title'],
      body_html: json['body_html'],
      subCategoryImage: SubCategoryImage.fomJson(json['image']),
    //  catId: json['']
    );
  }
}
class SubCategoryImage{
  String imageId,pId,position,alt,src;
  SubCategoryImage({this.imageId,this.pId,this.position,this.alt,this.src});
  factory SubCategoryImage.fomJson(Map<String,dynamic> json){
    var imgID=json['id'].toString();
    var productID=json['product_id'].toString();
    var subPosition=json['position'].toString();
    return SubCategoryImage(
      imageId: imgID,
      pId: productID,
      position: subPosition,
      src: json['src'],
      alt: json['alt']
    );
  }
}
