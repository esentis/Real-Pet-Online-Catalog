import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:realpet/components/state_management.dart';
import 'package:realpet/pages/login_page.dart';
import 'package:realpet/pages/register_page.dart';
import 'package:realpet/pages/results_page.dart';
import 'package:realpet/pages/search_page.dart';
import 'pages/storefront.dart';
import 'package:realpet/pages/product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<DrawerModel>(
            create: (_) => DrawerModel(drawerStatus: FSBStatus.FSB_CLOSE)),
        ListenableProvider<BottomSearchModel>(
            create: (_) => BottomSearchModel()),
        ListenableProvider<ResultsContainerModel>(
            create: (_) => ResultsContainerModel()),
      ],
      child: GetMaterialApp(
        title: 'Real Pet Catalog App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xffcbf1f5),
          sliderTheme: SliderThemeData(
            overlayColor: Colors.black,
            inactiveTrackColor: Colors.red,
            activeTrackColor: Colors.white,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
            valueIndicatorColor: Colors.green,
            activeTickMarkColor: Colors.cyan,
            trackHeight: 10,
            valueIndicatorTextStyle: GoogleFonts.comfortaa(),
            inactiveTickMarkColor: Colors.black,
            thumbColor: Colors.yellow,
          ),
        ),
        initialRoute: '/',
        namedRoutes: {
          '/': GetRoute(page: StoreFront()),
          '/login': GetRoute(page: LoginPage()),
          '/register': GetRoute(page: RegisterPage()),
          '/product': GetRoute(page: ProductPage()),
          '/results': GetRoute(page: ResultsPage()),
          '/search': GetRoute(page: SearchPage()),
        },
      ),
    );
  }
}
