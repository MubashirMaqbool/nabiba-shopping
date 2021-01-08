
import 'package:nabiba_app/Providers/CartBlock.dart';
import 'package:nabiba_app/Services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nabiba_app/ApiUtils/OrderApiUtils.dart';
import 'package:nabiba_app/Models/CartModel.dart';
import 'package:nabiba_app/Models/UserInfoModel.dart';
import 'package:nabiba_app/Services/CartSqliteServices.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PayPalPage extends StatefulWidget {
  List<CartModel> data;
  String price;
  UserInfoModel userInfoModel;
  PayPalPage({this.data,this.price,this.userInfoModel});
  
  @override
  _PayPalPageState createState() => _PayPalPageState();
}

class _PayPalPageState extends State<PayPalPage> {
  UserOrderServices userOrderServices;
  CartSqliteServices cartSqliteServices=CartSqliteServices();
  CartBlock cartBlock;
  bool isLoading=true;
  dynamic cartInfo;
  String _loadHTML() {

    return '''
  <html>
    <body onload="document.f.submit();">
      <form id="f" name="f" method="post" action="https://nodejspaypalbackend.herokuapp.com/pay">
        <input type="hidden" name="price" value="${widget.price}"/>
         <input type="hidden" name="data" value="" "/>
       
      </form>
    </body>
  </html>
''';
  }
  @override
  Widget build(BuildContext context) {
     userOrderServices=Provider.of<UserOrderServices>(context);
     cartBlock=Provider.of<CartBlock>(context);
     DateTime now = new DateTime.now();
     DateTime date = new DateTime(now.year, now.month, now.day);
       return SafeArea(
      child: Scaffold(
        body: Container(
          child:Container(
            child:  WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: Uri.dataFromString(_loadHTML(),mimeType: "text/html").toString(),
              onPageFinished:(page) async{
                 if(page.contains("/success")){
                   OrderApiUtils orderApiUtils=OrderApiUtils();
               String message=   await orderApiUtils.sendDataToServer(widget.data, widget.price.toString(), widget.userInfoModel);
                   if(message=="Success"){
                     for(int a=0;a<widget.data.length;a++){
                       await  userOrderServices.saveOrder(widget.data[a]);
                       await cartSqliteServices.delSpecificProduct(widget.data[a].product_id,cartBlock);
                       print(widget.data[a]);
                     }
                     Navigator.pop(context);
                     Fluttertoast.showToast(
                         msg: "You Paid To Nabiba Successfully! "
                                "Check Your Order History",
                         toastLength: Toast.LENGTH_LONG,
                         gravity: ToastGravity.CENTER,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.blue,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
                   }
                   else{
                     Navigator.pop(context);
                     Fluttertoast.showToast(
                         msg: "Something Went Wrong",
                         toastLength: Toast.LENGTH_LONG,
                         gravity: ToastGravity.CENTER,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.blue,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
                   }

                 }
                 else if(page.contains('/cancel')){

                   Fluttertoast.showToast(
                       msg: "You Cancelled Payment !",
                       toastLength: Toast.LENGTH_LONG,
                       gravity: ToastGravity.CENTER,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Colors.blue,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );

                   Navigator.pop(context);
                 }
              } ,
            ),
          ),
        ),
      ),
    );
  }
}
