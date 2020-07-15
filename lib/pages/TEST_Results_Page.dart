import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/results_page_components.dart';

import '../shop_logic.dart';

var response;

class TestResults extends StatefulWidget {
  @override
  _TestResultsState createState() => new _TestResultsState();
}

class _TestResultsState extends State<TestResults>
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
  _TestResultsState() {
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
    var screenInfo = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 750),
                width: screenInfo.size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(color: Color(0xff23374d), blurRadius: 25),
                  ],
                  border: Border.fromBorderSide(BorderSide(
                    color: Colors.red,
                    width: 1,
                  )),
                ),
                child: Row(
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
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Hero(
                        tag: "LOGO",
                        child: Container(
                          width: 150,
                          height: 90,
                          child: FlareActor(
                            'assets/logo.flr',
                            animation: _logoAnimation,
                            controller: _controls,
                            color: Colors.black,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // NUMBER OF RESULTS FOUND
              FutureBuilder(
                  future: _futureResultsText,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      String loadedResultsText = snapshot.data;
                      return Column(
                        children: [
                          Text(
                            "TEST TEST ${loadedResultsText.toString()} TEST",
                            style: GoogleFonts.comfortaa(
                                shadows: [
                                  Shadow(
                                      color: Color(0xFFce2e6c), blurRadius: 15),
                                ],
                                color: Color(0xff23374d),
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
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
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff23374d),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.zero,
                      bottomLeft: Radius.zero,
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0xff23374d), blurRadius: 25),
                    ],
                    border: Border.fromBorderSide(BorderSide(
                      color: Colors.red,
                      width: 1,
                    )),
                  ),
                  child: FutureBuilder(
                    future: _future,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<String> loaded = snapshot.data;
                        return ListWheelScrollView.useDelegate(
                          diameterRatio: 1,
                          offAxisFraction: 0.5,
                          onSelectedItemChanged: (index){
                            print(index);
                          },
                          itemExtent: 50,
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: loaded.length,
                              builder: (BuildContext context, int index) {
                            if (index < 0 || index > 10) {
                              return null;
                            }
                            return ResultsTile(
                              categoryId: _category[index],
                              img: _img[index],
                              desc: _desc[index],
                              originalPrice:
                              double.parse(_originalPrice[index]),
                              productName: loaded[index],
                              productSKU: _sku[index],
                              productId: int.parse(_id[index]),
                            );
                          }),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
