class ApiUtils{

  static var categoryApiUrl="https://980e22c91a1b8b82fbe00f186350a474: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@natistefastore.myshopify.com/admin/api/2020-10/custom_collections.json";





/* var allProductsUrl="https://980e22c91a1b8b82fbe00f186350a474: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@natistefastore.myshopify.com/admin/api/2020-10/products.json?fields=id,title,images";
    Future<void> productApiCalling() async{
      print("calling........>.");
      var response= await http.get(allProductsUrl);
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        print(data['products']);
        final parsed = data['products'].cast<Map<String, dynamic>>();
        List<ProductsModel> list= parsed.map<ProductsModel>((json) => ProductsModel.fromJson(json)).toList();
        print(list[0].productImages[1].src);
      }
    }

*/
}
