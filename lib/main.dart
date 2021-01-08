import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:nabiba_app/Services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:nabiba_app/ApiUtils/SubCategoryApiUtils.dart';
import 'package:nabiba_app/Pages/SplashScreenPage.dart';
import 'package:nabiba_app/Providers/SingleProductBlock.dart';
import 'package:nabiba_app/Services/LikedProductsServices.dart';
import 'package:provider/provider.dart';
import 'Providers/CartBlock.dart';

import 'StylesUtils/ScreenConfig/screenSizeInfoUtils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>SingleProductBlock()),
      ChangeNotifierProvider(create: (_)=>CartBlock()),
      ChangeNotifierProvider(create: (_)=>LikedProductsServices()),
      ChangeNotifierProvider(create: (_)=>SubCategoryApiUtils()),
      ChangeNotifierProvider(create: (_)=>UserOrderServices()),
    ], child:  MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      ScreenSizeInfo().getSizeInfo(constraints);
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      );
    });
  }
}
