import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('products')
          .orderBy('name', descending: false)
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
          final productCategory = product.data['category'];
          final productSKU =
              product.data['sku'] == '' ? '000-000' : product.data['sku'];
          final productWidget = ListTile(
            onTap: () {
              Get.bottomSheet(
                  ProductsEditScreen(productName: productName, id: id),
                  elevation: 30,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(50, 0),
                    topLeft: Radius.circular(30),
                  )));
            },
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.pets,
                  color: Colors.white,
                ),
                Text(productCategory ?? 'N/A'),
              ],
            ),
            title: Text(
              '$productName',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            subtitle: Text(
              '$productSKU',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              '$productPrice€',
              style: TextStyle(fontWeight: FontWeight.w900),
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
    );
  }
}

class ProductsEditScreen extends StatelessWidget {
  const ProductsEditScreen({
    @required this.productName,
    @required this.id,
  });

  final productName;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'ΠΡΟΣΘΗΚΗ ΣΕ ΚΑΤΗΓΟΡΙΑ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('$productName has been deleted from products');
                      Firestore.instance
                          .collection('products')
                          .document(id)
                          .delete();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 35,
                      semanticLabel: 'Διαγραφη Προϊόντος',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 250,
            height: 250,
            child: ListView(
              reverse: false,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    print('$productName added to Grooming category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'grooming'},
                    );
                  },
                  title: Text(
                    'Grooming',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Shampoo category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'shampoo'},
                    );
                  },
                  title: Text(
                    'Σαμπουάν',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Toys category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'toys'},
                    );
                  },
                  title: Text(
                    'Παιχνίδια',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Dog food category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'dogFood'},
                    );
                  },
                  title: Text(
                    'Τροφες Σκυλου',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Catfood category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'catFood'},
                    );
                  },
                  title: Text(
                    'Τροφες Γάτας',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Bones category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'bones'},
                    );
                  },
                  title: Text(
                    'Κοκκαλα',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Vitamines category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'vitamines'},
                    );
                  },
                  title: Text(
                    'Βιταμίνες',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Bowl category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'bowl'},
                    );
                  },
                  title: Text(
                    'Μπωλ τροφών',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Misc category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'misc'},
                    );
                  },
                  title: Text(
                    'Διάφορα',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print('$productName added to Bird category');
                    Firestore.instance
                        .collection('products')
                        .document(id)
                        .updateData(
                      {'category': 'bird'},
                    );
                  },
                  title: Text(
                    'Πουλια',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 3,
              children: <Widget>[
                CategoryIcon(
                  text: 'Τροφή σκύλου',
                  categoryName: 'dogFood',
                  categoryIcon: FontAwesomeIcons.dog,
                  iconColor: Colors.white,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Τροφή γάτας',
                  categoryName: 'catFood',
                  categoryIcon: FontAwesomeIcons.cat,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Grooming',
                  categoryName: 'grooming',
                  categoryIcon: FontAwesomeIcons.cut,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Σαμπουάν',
                  categoryName: 'shampoo',
                  categoryIcon: FontAwesomeIcons.soap,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Μπωλ φαγητού',
                  categoryName: 'bowl',
                  categoryIcon: Icons.fastfood,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Παιχνίδια',
                  categoryName: 'toys',
                  categoryIcon: Icons.toys,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Κόκκαλα',
                  categoryName: 'bones',
                  categoryIcon: FontAwesomeIcons.bone,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Βιταμίνες',
                  categoryName: 'vitamines',
                  categoryIcon: FontAwesomeIcons.tablets,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Πουλιά',
                  categoryName: 'bird',
                  categoryIcon: FontAwesomeIcons.dove,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Επαγγελματικά',
                  categoryName: 'pro',
                  categoryIcon: FontAwesomeIcons.userMd,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Διάφορα',
                  categoryName: 'misc',
                  categoryIcon: FontAwesomeIcons.ellipsisH,
                  color: Color(0xFF00a1ab),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  CategoryIcon({
    this.text,
    this.categoryName,
    this.color,
    this.categoryIcon,
    this.iconColor,
  });
  final String text;
  final String categoryName;
  final Color color;
  final List argumentsList = [];
  final IconData categoryIcon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    argumentsList.add(categoryName);
    argumentsList.add(text);
    argumentsList.add(categoryIcon);
    return GestureDetector(
      onTap: () {
        print('tapped');
        Get.toNamed('/results', arguments: argumentsList);
      },
      child: Material(
        color: color,
        elevation: 8,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xFFf1d1d1),
            width: 5,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        shadowColor: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  categoryIcon,
                  color: iconColor,
                  size: 38,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchProduct extends StatelessWidget {
  var _sku;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Alert(
            context: context,
            style: AlertStyle(
              alertBorder: OutlineInputBorder(
                gapPadding: 15,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomRight: Radius.circular(20),
                ),
              ),
              overlayColor: Color(0xFF00263b),
              buttonAreaPadding: EdgeInsets.only(top: 50),
              backgroundColor: Colors.transparent,
              titleStyle: GoogleFonts.comfortaa(
                color: Colors.white,
              ),
            ),
            title: "Αναζήτηση προϊόντος με βάση τον κωδικό",
            content: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: TextField(
                maxLength: 10,
                style: GoogleFonts.comfortaa(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                onChanged: (typed){
                  _sku=typed;
                },
                enabled: true,
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.fingerprint),
                  hintText: 'Κωδικός προϊόντος',
                  hintStyle: GoogleFonts.comfortaa(
                    fontSize: 15,
                    fontWeight: FontWeight.w900
                  ),
                  border: OutlineInputBorder(
                    gapPadding: 15,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                ),
                cursorColor: Colors.red,
              ),
            ),
            buttons: [
              DialogButton(
                color: Colors.white,
                onPressed: () {
                  Get.toNamed('/search',arguments : _sku);
                },
                radius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.elliptical(5, 5)),
                child: Text(
                  "Αναζήτηση",
                  style: TextStyle(
                    color: Color(0xFF00263b),
                    fontSize: 20,
                  ),
                ),
              )
            ]).show();
      },
      child: Icon(FontAwesomeIcons.search,size: 30,),
    );
  }
}