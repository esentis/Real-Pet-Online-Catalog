import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/animated_logo.dart';
import 'package:realpet/components/constants.dart';
import 'package:realpet/components/results_page_components.dart';
import 'package:realpet/shop_logic.dart';

var response;

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  final List<String> _data = [];
  final List<String> _sku = [];
  final List<String> _img = [];
  final List<String> _originalPrice = [];
  final List<String> _desc = [];
  final List<String> _category = [];
  final List<String> _id = [];
  Future<List<String>> _future;
  Future _futureResultsText;
  int _currentPage = 1, _limit;
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  final Map _allArguments = Get.arguments;
  Animation<Color> animation;
  AnimationController _animationController;

  ///constructor
  _ResultsPageState() {
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd && _currentPage <= _limit) {
        setState(() {
          _future = loadData();
        });
      }
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
    var responseCheck = checkResponse(response);
    // If we fail getting a response from the server we redirect to the storefront
    if (!responseCheck) {
      await Get.offAllNamed('/');
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
    animation = Tween<Color>(
      begin: Colors.white,
      end: Colors.blueAccent,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: kStoreFrontBackgroundImage,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                // LOGO CONTAINER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: kBackButtonWidth,
                          height: kBackButtonHeight,
                          decoration: BoxDecoration(
                              color: kBackButtonBackgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.arrow_back,
                            color: kMainColor,
                            size: kBackButtonSize,
                          ),
                        ),
                      ),
                    ),
                    // LOGO
                    const RealPetLogo(
                      blurRadius: 0,
                      containerHeight: 100,
                      containerWidth: 150,
                      topRightRadius: Radius.circular(60),
                      topLeftRadius: Radius.circular(60),
                      bottomRightRadius: Radius.circular(60),
                      bottomLeftRadius: Radius.circular(60),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                  ],
                ),
                const SizedBox(
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
                              'Βρέθηκαν συνολικά ${loadedResultsText.toString()} προϊόντα',
                              style: GoogleFonts.comfortaa(
                                  shadows: [
                                    Shadow(
                                        color: kBorderAndShadowColors,
                                        blurRadius: kResultsTextBlurRadius),
                                  ],
                                  color: kResultsTextColor,
                                  fontSize: kResultsTextFontSize,
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
                const SizedBox(
                  height: 25,
                ),
                // RESULTS
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.zero,
                        bottomLeft: Radius.zero,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF00263b),
                            blurRadius: kResultsBlurRadius),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: FutureBuilder(
                        future: _future,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                  originalPrice:
                                      double.parse(_originalPrice[index]),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
