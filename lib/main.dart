import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realpet/pages/login_page.dart';
import 'package:realpet/pages/register_page.dart';
import 'package:realpet/pages/results_page.dart';
import 'package:realpet/pages/search_product_page.dart';
import 'pages/storefront.dart';
import 'package:realpet/pages/product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WooCommerce Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF00263b),
      ),
      initialRoute: '/',
      namedRoutes: {
        '/': GetRoute(page: StoreFront()),
        '/results': GetRoute(page: ResultsPage()),
        '/login': GetRoute(page: LoginPage()),
        '/register': GetRoute(page: RegisterPage()),
        '/product': GetRoute(page: ProductPage()),
        '/search': GetRoute(page: SearchProduct()),
      },
    );
  }
}
