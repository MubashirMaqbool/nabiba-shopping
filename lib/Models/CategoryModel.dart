class CategoryModel{
  String categoryId,categoryTitle,categorySortOrder;
  CategoryModel({this.categoryId,this.categoryTitle,this.categorySortOrder});
  factory CategoryModel.fromJason(Map<String,dynamic> json){
    var  catId=json['id'].toString();
    return CategoryModel(
      categoryId: catId,
      categoryTitle: json['title'],
      categorySortOrder: json['sort_order']
    );
  }
}