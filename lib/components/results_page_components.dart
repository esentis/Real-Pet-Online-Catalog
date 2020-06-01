import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:transparent_image/transparent_image.dart';

var logger = new Logger();

// SEARCH RESULTS PAGE
class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

// SEARCH RESULTS PAGE STATE
class _SearchResultsState extends State<SearchResults> {
  List products = [];
  @override
  void initState() {
    super.initState();
    products = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ResultsTile(
                    categoryId: products[index]['categoryId'],
                    img: products[index]['img'],
                    desc: products[index]['description'],
                    originalPrice: products[index]['originalPrice'],
                    productName: products[index]['name'],
                    productSKU: products[index]['sku'],
                    productId: products[index]['id'],
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
  ResultsTile({
    this.productName,
    this.originalPrice,
    this.productSKU,
    this.img,
    this.desc,
    this.categoryId,
    this.productId,
  });
  final int categoryId;
  final String productName;
  final String productSKU;
  final double originalPrice;
  final String img;
  final String desc;
  final int productId;

  @override
  Widget build(BuildContext context) {
    List argumentsList = [
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
        '$productName',
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        '$productSKU',
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(),
      ),
      trailing: Text(
        '${originalPrice.toString()}€',
        style: GoogleFonts.comfortaa(
          fontSize: 18,
        ),
      ),
    );
  }
}
