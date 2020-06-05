import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/results_page_components.dart';

import '../shop_logic.dart';

var response;

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => new _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  List<String> _data = [];
  List<String> _sku = [];
  List<String> _img = [];
  List<String> _originalPrice = [];
  List<String> _desc = [];
  List<String> _category = [];
  List<String> _id = [];
  Future<List<String>> _future;
  Future _futureResultsText;
  int _currentPage = 1, _limit;
  ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  Map _allArguments = Get.arguments;
  Animation<Color> animation;
  AnimationController _animationController;
  String _logoAnimation = "idle";
  final FlareControls _controls = FlareControls();

  ///constructor
  _ResultsPageState() {
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd && _currentPage <= _limit)
        setState(() {
          _future = loadData();
        });
    });
    _future = loadData();
    _futureResultsText = resultsText();
  }

  /// load data
  Future<List<String>> loadData() async {
    response = await searchProducts(
        category: _allArguments['category'],
        term: _allArguments['searchTerm'],
        highestPrice: _allArguments['highestPrice'],
        lowestPrice: _allArguments['lowestPrice'],
        page: _currentPage);
    bool responseCheck = checkResponse(response);
    // If we fail getting a response from the server we redirect to the storefront
    if (!responseCheck) {
      Get.offAllNamed('/');
    }
    _limit = response['totalPages'];
    for (var i = 0; i < response['results'].length; i++) {
      // IT'S UGLY, I WILL PIMP IT UP LATER
      _data.add(response['results'][i]['name']);
      _sku.add(response['results'][i]['sku']);
      _desc.add(response['results'][i]['description']);
      _img.add(response['results'][i]['img']);
      _originalPrice.add(response['results'][i]['originalPrice'].toString());
      _category.add(response['results'][i]['category']);
      _id.add(response['results'][i]['id'].toString());
    }
    _currentPage++;
    return _data;
  }

  Future resultsText() async {
    response = await searchProducts(
        category: _allArguments['category'],
        term: _allArguments['searchTerm'],
        highestPrice: _allArguments['highestPrice'],
        lowestPrice: _allArguments['lowestPrice'],
        page: _currentPage);
    return response['totalProducts'].toString();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<Color>(begin: Colors.white, end: Colors.blueAccent)
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //BACK BUTTON
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
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
                ),
                Hero(
                  tag: "LOGO",
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
                  width: 50,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: _futureResultsText,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    String loadedResultsText = snapshot.data;
                    return Text(
                      "Βρέθηκαν συνολικά ${loadedResultsText.toString()} προϊόντα",
                      style: GoogleFonts.comfortaa(fontSize: 16),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: animation,
                    ),
                  );
                }),
            SizedBox(height: 25),
            // RESULTS
            Expanded(
              child: FutureBuilder(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<String> loaded = snapshot.data;
                    return ListView.builder(
                      itemCount: loaded.length,
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) {
                        return ResultsTile(
                          categoryId: _category[index],
                          img: _img[index],
                          desc: _desc[index],
                          originalPrice: double.parse(_originalPrice[index]),
                          productName: loaded[index],
                          productSKU: _sku[index],
                          productId: int.parse(_id[index]),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      valueColor: animation,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
