import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/results_page_components.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List arguments = Get.arguments;
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // BACK BUTTON
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
                SizedBox(
                  width: 50,
                ),
                // CATEGORY TITLE
                Text(
                  arguments[0]['category'],
                  style: GoogleFonts.comfortaa(
                    fontSize: 30,
                  ),
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
