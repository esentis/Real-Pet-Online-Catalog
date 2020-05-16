import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components.dart';
import 'package:transparent_image/transparent_image.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
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
                Text(
                  Get.arguments[1],
                  style: GoogleFonts.comfortaa(
                    fontSize: 30,
                  ),
                ),
                SearchProduct(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('products')
                  .where('category', isEqualTo: Get.arguments[0])
                  .snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
                final products = snapshot.data.documents;
                List<ListTile> productWidgets = [];
                for (var product in products) {
                  final productName = product.data['name'];
                  final productPrice = product.data['price'][0].toString();
                  final prices = product.data['price'];
                  final id = product.documentID;
                  final category = product.data['category'];
                  final desc =
                      product.data['desc'] ?? 'No description added yet';
                  final img =
                      product.data['img'] ?? 'https://i.imgur.com/WrCqxVu.png';
                  final productSKU = product.data['sku'];
                  List arguments = [
                    productName,
                    prices,
                    img,
                    productSKU,
                    desc,
                    category
                  ];
                  final productWidget = ListTile(
                    onTap: () {
                      Get.toNamed('/product', arguments: arguments);
                    },
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: img,
                        ),
                      ),
                    ),
//                    FadeInImage.memoryNetwork(
//                      placeholder: kTransparentImage,
//                      image: img,
//                    ),
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
                      '$productPrice€',
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                      ),
                    ),
                  );
                  productWidgets.add(productWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: false,
                    children: productWidgets,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}


