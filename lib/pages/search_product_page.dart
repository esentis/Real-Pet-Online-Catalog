import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/results_page_components.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed('/');
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF00263b),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Αναζήτηση προϊόντος',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: SearchResults()),
          ],
        ),
      ),
    ));
  }
}
