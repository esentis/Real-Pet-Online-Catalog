import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:realpet/components/results_page_components.dart';

import '../shop_logic.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

String _logoAnimation = 'idle';
final FlareControls _controls = FlareControls();
var response;
var _currentPage = 30;
bool _loading = true;

class _ResultsState extends State<Results> {
//  dynamic arguments = Get.arguments;
  ScrollController _scrollController = new ScrollController();

  getData() async {
    response =
        await searchProducts(category: Get.arguments, page: _currentPage);
    _currentPage++;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: SpinKitWave(
        color: Color(0xFF00263b).withOpacity(0.8),
        size: 30.0,
      ),
      inAsyncCall: _loading,
      child: Scaffold(
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
              Text("TEST "),
              // RESULTS
              Expanded(
                child: Container(
                  child: Center(
                    child: ListView.builder(
                      controller: _scrollController
                        ..addListener(() {
                          var triggerFetchMoreSize =
                              0.9 * _scrollController.position.maxScrollExtent;
                          if (_scrollController.position.pixels >
                              triggerFetchMoreSize) {
                            // call fetch more method here
                            logger.i("MAX CONTENT");
                            _currentPage+=_currentPage+10;
                            setState(() {
                              
                            });
                          }
//                  if (_scrollController.position.pixels ==
//                      _scrollController.position.maxScrollExtent) {
//                    logger.i("MAX CONTENT");
//                  }
                        }),
                      itemCount: _currentPage,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$index"),
//                          child: ResultsTile(
//                            categoryId: response['results'][index]['category'] ?? "null",
//                            img: response['results'][index]['img'] ?? "null",
//                            desc: response['results'][index]['description']?? "null",
//                            originalPrice: response['results'][index]
//                                ['originalPrice']?? "null",
//                            productName: response['results'][index]['name']?? "null",
//                            productSKU: response['results'][index]['sku']?? "null",
//                            productId: response['results'][index]['id']?? "null",
//                          ),
                        );
                      },
                    ),
                  ),
                ),
//              child: SearchResults(
//                products: arguments,
//              ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
