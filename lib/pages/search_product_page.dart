import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
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
                Flexible(
                  child: Text(
                    'Αναζήτηση κωδικού \n${Get.arguments}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 20,
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
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('products')
                  .where('sku', isEqualTo: Get.arguments)
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
                  final productPrice = product.data['price'];
                  final id = product.documentID;
                  final desc =
                      product.data['desc'] ?? 'No description added yet';
                  final img =
                      product.data['img'] ?? 'https://i.imgur.com/WrCqxVu.png';
                  final productSKU = product.data['sku'];
                  List arguments = [
                    productName,
                    productPrice,
                    img,
                    productSKU,
                    desc
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
                      '${product.data['price'][0]}€',
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                      ),
                    ),
                  );
                  productWidgets.add(productWidget);
                }
                return products.length > 0
                    ? Expanded(
                        child: ListView(
                          reverse: false,
                          children: productWidgets,
                        ),
                      )
                    : Padding(
                      padding: const EdgeInsets.only(top : 40.0),
                      child: Text(
                          'Δυστυχώς δεν βρέθηκαν προϊόντα \nμε τον κωδικό που δώσατε',
                          textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                      fontSize: 20
                  ),
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
