import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/results_page_components.dart';

import '../shop_logic.dart';

var response;

class InfiniteScroll extends StatefulWidget {
  @override
  _InfiniteScrollState createState() => new _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  List<String> _data = [];
  List<String> _sku = [];
  List<String> _img = [];
  List<String> _originalPrice = [];
  List<String> _desc = [];
  List<String> _category = [];
  List<String> _id = [];
  Future<List<String>> _future;
  int _currentPage = 1, _limit;
  ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  ///constructor
  _InfiniteScrollState() {
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd && _currentPage<=_limit)
        setState(() {
          _future = loadData();
        });
    });
    _future = loadData();
  }

  ///Mimic load data
  Future<List<String>> loadData() async {
    print("Current page is $_currentPage");
    response = await searchProducts(category: 3, page: _currentPage);
    _limit = response['totalPages'];
    for (var i = 0; i < response['results'].length; i++) {
      print(response['totalProducts']);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<String> loaded = snapshot.data;
              return ListView.builder(
                itemCount: loaded.length,
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return ResultsTile(
                    categoryId:_category[index] ,
                    img: _img[index],
                    desc: _desc[index],
                    originalPrice: double.parse(_originalPrice[index]),
                    productName: loaded[index],
                    productSKU: _sku[index],
                    productId: 1,
                  );
                  return ListTile(
                    title: Text(
                      loaded[index],
                      style: GoogleFonts.comfortaa(
                        fontSize: 40,
                      ),
                    ),
                    subtitle: Text(
                      _sku[index],
                      style: GoogleFonts.comfortaa(
                        fontSize: 40,
                      ),
                    ),
                    onTap: () {
                      print(index);
                    },
                  );
                },
              );
            }
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
