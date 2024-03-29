import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/shop_logic.dart';
import 'package:transparent_image/transparent_image.dart';

var _currentPage = 1;

// SEARCH RESULTS PAGE
class SearchResults extends StatefulWidget {
  const SearchResults({this.products});
  final dynamic products;
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

// SEARCH RESULTS PAGE STATE
class _SearchResultsState extends State<SearchResults> {
  List productList;
  void productsList(Map<String, dynamic> products) {
    products.forEach((key, value) {
      if (key == 'results') {
        for (var i = 0; i < 10; i++) {
          productList.add(value[i]['name'].toString());
        }
      }
    });
  }

  void loadNext() {}

  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    productsList(widget.products);
    return Scaffold(
      body: SafeArea(
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
                    logger.i('MAX CONTENT');
                    if (_currentPage <= widget.products['totalPages']) {
                      searchProducts(page: ++_currentPage, category: 1);
                      setState(() {});
                    } else {
                      logger.w('No more pages to load');
                    }
                  }
                }),
              itemCount: widget.products['results'].length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ResultsTile(
                    categoryId: widget.products['results'][index]['category'],
                    img: widget.products['results'][index]['img'],
                    desc: widget.products['results'][index]['description'],
                    originalPrice: widget.products['results'][index]
                        ['originalPrice'],
                    productName: widget.products['results'][index]['name'],
                    productSKU: widget.products['results'][index]['sku'],
                    productId: widget.products['results'][index]['id'],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// RESULTS' TILE
class ResultsTile extends StatelessWidget {
  const ResultsTile({
    this.productName,
    this.originalPrice,
    this.productSKU,
    this.img,
    this.desc,
    this.categoryId,
    this.productId,
  });
  final String categoryId;
  final String productName;
  final String productSKU;
  final double originalPrice;
  final String img;
  final String desc;
  final int productId;

  @override
  Widget build(BuildContext context) {
    var argumentsList = [
      productName,
      originalPrice,
      img,
      productSKU,
      desc,
      categoryId,
      productId
    ];
    return ListTile(
      onTap: () {
        Get.toNamed('/product', arguments: argumentsList);
      },
      leading: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Hero(
            tag: productId,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: img,
            ),
          ),
        ),
      ),
      title: Text(
        productName,
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(
            color: const Color(0xffeeeeee),
            fontSize: 16,
            fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        productSKU.toString(),
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(
          shadows: [
            const Shadow(color: Colors.black, blurRadius: 5),
          ],
        ),
      ),
      trailing: Text(
        '${originalPrice.toString()}€',
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(
            color: const Color(0xffeeeeee),
            fontSize: 18,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
