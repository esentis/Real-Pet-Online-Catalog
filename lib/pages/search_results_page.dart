import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/results_page_components.dart';

class SearchProductResults extends StatefulWidget {
  @override
  _SearchProductResultsState createState() => _SearchProductResultsState();
}

String _logoAnimation = 'idle';
final FlareControls _controls = FlareControls();

class _SearchProductResultsState extends State<SearchProductResults> {
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
                    Get.back();
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
                // TITLE
                Hero(
                  tag: "TEST",
                  child: Container(
                    width: 150,
                    height: 90,
                    child: FlareActor(
                      'assets/logo.flr',
                      animation: _logoAnimation,
                      controller: _controls,
                      color: Colors.white,
                      fit: BoxFit.fitWidth,
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
            // RESULTS
            Expanded(
              child: SearchResults(
                products: Get.arguments,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
